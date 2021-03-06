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

  #=====================================================================================================================
  # Считывание из БД
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

    Department_list.new(list_departments)
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
    Employee_list.new(list_employee)
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
    Job_list.new(list_jobs)
  end

  # Считывание должностей
  def posts_read_from_db
    list_posts = []
    posts = @client.query("SELECT post.name as post_name,department.name as department_name,salary,vacancy FROM post
                          join department ON post.id_department = department.id")
    posts.each do |post|
      list_posts.push(Post.new(department: post["department_name"], salary:post["salary"], name: post["post_name"], vacancy: post["vacancy"]))
    end
    Post_list.new(list_posts)
  end
  #=====================================================================================================================
  # Запись в БД
  # Запись сотрудников в БД
  def employees_write_to_db(list)
    # Проверка, что поля корректны
    emp = Employee.new(surname: list[0],firstname: list[1],lastname: list[2], bd: list[3],passport: list[4], phone: list[5],
                       address: list[6],email: list[7])
    jobs = @client.query("INSERT INTO `car_dealership`.`employee` (`surname`, `firstname`, `lastname`, `birthday`,
`passport`, `address`, `email`, `phone`) VALUES ('#{emp.surname}', '#{emp.firstname}', '#{emp.lastname}', '#{emp.bd}', '#{emp.passport}',
 '#{emp.address}', '#{emp.email}', '#{emp.phone}');")
  end
  #=====================================================================================================================
  # Удаление из БД
  # Удаление сотрудников из БД
  def employees_delete_from_db(list)
    @client.query("DELETE FROM employee WHERE(`surname` = '#{list[0][0]}')")
  end
  #=====================================================================================================================
  # Обновление записи в БД
  def employees_update(list)
    emp = Employee.new(surname: list[0],firstname: list[1],lastname: list[2], bd: list[3],passport: list[4], phone: list[5],
                       address: list[6],email: list[7])
    @client.query("UPDATE `car_dealership`.`employee` SET `surname`='#{emp.surname}', `firstname`='#{emp.firstname}',
  `lastname`='#{emp.lastname}', `birthday`='#{emp.bd}', `passport`='#{emp.passport}',
 `address`='#{emp.address}', `email`='#{emp.email}', `phone`='#{emp.phone}' WHERE `passport`='#{list[4]}'")
  end
end