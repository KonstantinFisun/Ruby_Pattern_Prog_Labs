Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
require 'mysql2'

class DB_driver
  # Конструктор
  # Поле, содержащее объект
  @@instance = nil

  def DB_driver.get_instance
    if @@instance
      @@instance.set_parameters
    else
      @@instance = DB_driver.new
    end
    @@instance
  end

  # "Ленивая инициализация"
  def set_parameters
    # Подключение базы данных
    @client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "12345", :database => "car_dealership")
  end

  # Приватный конструктор
  private def initialize
    self.set_parameters
  end

  # Считывание отделов
  def departments_read_from_db
    list_departments = [] # Список отделов
    results = @client.query("select * from car_dealership.department")
    results.each do |row|
      name = row["name"] # Считали имя департамента
      phone = row["phone"] # Считали телефон департамента

      # Считали обязанности
      list_duty = []
      duty = @client.query("select duty_name from car_dealership.duty where id_department = #{row["id"]}")
      duty.each do |dut|
        list_duty.push(dut["duty_name"])
      end

      # Считали должности
      list_posts = []
      posts = @client.query("select * from car_dealership.post where id_department = #{row["id"]}")
      posts.each do |post|
        list_posts.push(Post.new(department: name, salary:post["salary"], name: post["name"], vacancy: post["vacancy"]))
      end

      list_departments.push(Department.new(name,phone,list_duty,Post_list.new(list_posts)))
    end

    list_departments
  end

  # Считывание сотрудников
  def employees_read_from_db
    # Считали работников
    list_employee = []
    employees = @client.query("SELECT * FROM employee")
    employees.each do |employee|
      list_job = [] # Список работ сотрудника
      jobs = @client.query("SELECT * FROM job
                            join post ON post.id_post = job.id_post
                            where job.id_employee = #{employee["id"]}")
      jobs.each do |job|
        list_job.push(Job.new(post_name: job["name"], start_date: job["start_date"], date_of_dismissal: job["date_of_dismissal"],
                              percentage_bid: job["percentage_bid"]))
      end
      list_employee.push(Employee.new(surname: employee["surname"], firstname: employee["firstname"], lastname: employee["lastname"],
                                      bd: employee["birthday"], phone: employee["phone"], passport: employee["passport"],
                                      address: employee["address"], email: employee["email"], job_list: Job_list.new(list_job)))
    end
    list_employee
  end

  # Считывание работ
  def jobs_read_from_db
    list_jobs = []
    jobs = @client.query("SELECT *, post.name as post_name FROM job
                        join employee ON job.id_employee = employee.id
                        join post ON job.id_post = post.id_post")
    jobs.each do |job|
      list_jobs.push(Job.new(post_name: job["post_name"],
                             employee: Employee.new(surname: job["surname"], firstname: job["firstname"], lastname: job["lastname"],
                                                    bd: job["birthday"], phone: job["phone"], passport: job["passport"],
                                                    address: job["address"], email: job["email"]),
                             start_date: job["start_date"], date_of_dismissal: job["date_of_dismissal"], percentage_bid: job["percentage_bid"]))
    end
    list_jobs
  end

  # Считывание должностей
  def posts_read_from_db
    list_posts = []
    posts = @client.query("SELECT post.name as post_name,department.name as department_name,salary,vacancy FROM post
                          join department ON post.id_department = department.id")
    posts.each do |post|
      list_posts.push(Post.new(department: post["department_name"], salary:post["salary"], name: post["post_name"], vacancy: post["vacancy"]))
    end
    list_posts
  end
end