path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
require "yaml"
require "yaml/store"

class Employee_list < Parent_list
  # Конструктор
  # Поле, содержащее объект
  @@instance = nil

  def Employee_list.get_instance(*list)
    if @@instance
      @@instance.set_parameters(list)
    else
      @@instance = Employee_list.new(list)
    end
    @@instance
  end

  # "Ленивая инициализация"
  def set_parameters(list)
    # Список работников
    @children_list = list
    @index = nil
  end

  # Приватный конструктор
  private def initialize(list)
    self.set_parameters(list)
  end


  def to_s
    s = ""
    @children_list.each_index{|i| s += "\nРаботник - #{i}\n#{@children_list[i]}"}
    s
  end

  # Урезанный формат ФИО
  def cut_to_s
    s = ""
    @children_list.each_index{|i| s += "\nРаботник - #{i}\n#{@children_list[i].cut}"}
    s
  end
  # Сортировка по Фамилии
  def sort_by!
    @children_list.sort_by!{|a| a.surname}
  end

  #=====================================================================================================================
  # TXT Сереализация и десереализация
  # Считывание всех отделов из файла
  def Employee_list.read_from_txt(file)
    file = File.new(file, "r")
    list_employees = [] # Список отделов
    for line in file.readlines
      list_employees.push(Employee.read_line(line))
    end
    file.close
    get_instance(list_employees)
  end

  # Запись всех отделов в файл
  def Employee_list.write_to_txt(file)
    File.open(file, "w") do |f|
      @children_list.each do |x|
      f.puts("#{x.surname} #{x.firstname} #{x.lastname};#{x.bd};#{x.passport};#{x.phone};#{x.address};#{x.email}")
      end
    end
  end
  #=====================================================================================================================
  # YAML Сереализация и десереализация
  # Считывание всех должностей из YAML
  def Job_list.read_from_yaml(file)
    store = YAML::Store.new file
    list_posts = ""
    File.open(file, 'r') do |f|
      while (line = f.gets)
        list_posts += line
      end
    end
    get_instance(store.load(list_posts))
  end

  # Запись всех должностей в YAML
  def write_to_yaml(file)
    File.open(file,"w") do |f|
      f.puts YAML.dump(@children_list)
    end
  end
  #=====================================================================================================================
  # Считывание из БД
  def Employee_list.read_from_db
    new(DB_driver.get_instance.employees_read_from_db)
  end
  #=====================================================================================================================

  # Метод возвращающий коллекцию, в названии которых
  # содержится введенная в аргументе строка как подстрока.
  def all_employees_with_substring(str)
    Employee_list.new(@children_list.find_all do |x|
      x.surname[str] or x.firstname[str] or x.lastname[str] or
      x.bd[str] or x.passport[str] or x.address[str] or x.phone[str] or x.email[str]
    end)
  end

  # Подсчет полного возраста
  def age_in_completed_years (bd, today)
    age = today.year - bd.year
    age = age - 1 if (
         bd.month >  today.month or
        (bd.month >= today.month and bd.day > today.day)
    )
    age
  end

  # Метод возвращающий людей, конкретного возраста
  def employees_of_a_specific_age(age)
    today = Time.new # Текущая дата
    Employee_list.new(@children_list.find_all do |x|
      data = x.bd.split(".")
      age_in_completed_years(Time.new(data[2],data[1], data[0]), today) == age
    end)
  end

  # Метод  возвращающий людей, младше заданного возраста
  def employees_of_the_youngest_age(age)
    today = Time.new # Текущая дата
    Employee_list.new(@children_list.find_all do |x|
      data = x.bd.split(".")
      age_in_completed_years(Time.new(data[2],data[1], data[0]), today) < age
    end)
  end

  # Метод  возвращающий людей, старше заданного возраста
  def employees_of_the_olderest_age(age)
    today = Time.new # Текущая дата
    Employee_list.new(@children_list.find_all do |x|
      data = x.bd.split(".")
      age_in_completed_years(Time.new(data[2],data[1], data[0]), today) > age
    end)
  end

  # Метод  возвращающий людей в заданном диапазоне
  def employees_of_the_range_age(age_a, age_b)
    today = Time.new # Текущая дата
    Employee_list.new(@children_list.find_all do |x|
      data = x.bd.split(".")
       age_in_completed_years(Time.new(data[2],
        data[1], data[0]), today) < age_b and age_in_completed_years(Time.new(data[2],
         data[1], data[0]), today) > age_a
    end)
  end

  #=====================================================================================================================
  # Метод, сортировки по зарплате трудоустроенных
  # Аргумент: зарплаты
  def sort_by_salary(posts)
    @children_list.find_all{|x| if x.total_salary(posts) != 0 then x end}.sort_by!{|x| x.total_salary(posts)}
  end

  # Метод, выводящий первые k человек с самой высокой зарплатой
  def first_k_employee_sal(posts, k)
    sort_by_salary(posts).reverse.take(k)
  end
end
