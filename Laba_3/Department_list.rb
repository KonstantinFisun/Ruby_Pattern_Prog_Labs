path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

require "yaml"
require "yaml/store"

class Department_list < Parent_list
  # Конструктор
  def initialize(list_departments)
    super(list_departments)
  end

  def to_s
    s = ""
    @children_list.each_index{|i| s += "Отдел - #{i}\n#{@children_list[i]}"}
    s
  end

  # Урезанный формат
  def cut_to_s
    s = ""
    @children_list.each_index{|i| s += "Отдел - #{i}\n#{@children_list[i].cut}"}
    s
  end
  # Сортировка по имени
  def sort_by!
    @children_list.sort_by!{|a| a.name}
  end

  #=====================================================================================================================
  # TXT Сереализация и десереализация
  # Считывание всех отделов из файла
  def Department_list.read_from_txt(file)
    file = File.new(file, "r")
    list_departments = [] # Список отделов
    for line in file.readlines
      list_departments.push(Department.read_line(line))
    end
    file.close
    new(list_departments)
  end

  # Запись всех отделов в файл
  def Department_list.write_to_txt(file)
    File.open(file, "w") do |f|
      @children_list.each do |x|
        f.puts("#{x.name};#{x.phone};#{x.duty_write_txt};#{x.name+"-должности.txt"}")
        x.posts_write_txt(x.name+"-должности.txt")
      end
    end
  end

  #=====================================================================================================================
  # YAML Сереализация и десереализация
  # Считывание всех отделов из YAML
  def Department_list.read_from_yaml(file)
    store = YAML::Store.new file
    list_departments = ""
    File.open(file, 'r') do |f|
      while (line = f.gets)
        list_departments += line
      end
    end
    new(store.load(list_departments))
  end

  # Запись всех отделов в YAML
  def write_to_yaml(file)
    File.open(file, "w") do |f|
      f.puts(YAML.dump(@children_list))
    end
  end
  #=====================================================================================================================
  # Считывание из БД
  def Department_list.read_from_db(client)
    list_departments = [] # Список отделов
    results = client.query("select * from car_dealership.department")
    results.each do |row|
      name = row["name"] # Считали имя департамента
      phone = row["phone"] # Считали телефон департамента

      # Считали обязанности
      list_duty = []
      duty = client.query("select duty_name from car_dealership.duty where id_department = #{row["id"]}")
      duty.each do |dut|
        list_duty.push(dut["duty_name"])
      end

      # Считали должности
      list_posts = []
      posts = client.query("select * from car_dealership.post where id_department = #{row["id"]}")
      posts.each do |post|
        list_posts.push(Post.new(department: name, salary:post["salary"], name: post["name"], vacancy: post["vacancy"]))
      end

      list_departments.push(Department.new(name,phone,list_duty,Post_list.new(list_posts)))
    end

    new(list_departments)
  end
  #=====================================================================================================================

  # Сортировка по количеству вакансий
  def sort_by_vacancy!
    @children_list.sort_by!{|a| a.count_vacancy}
  end

  # Метод возвращающий коллекцию, в названии которых
  # содержится введенная в аргументе строка как подстрока.
  def all_departments_with_substring(str)
    new(@children_list.find_all do |x|
      x.name[str] or x.phone[str]
    end)
  end
  #=====================================================================================================================
  # Метод, строящий Employee_list всех сотрудников, находящихся сейчас на данных должностях
  def employees_in_posts(employee_list)
    list = []
    @children_list.each{|x| list.append(x.employees_in_posts(employee_list))}
    Employee_list.new(list.flatten)
  end


end
