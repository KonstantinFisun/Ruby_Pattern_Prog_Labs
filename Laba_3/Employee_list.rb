path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
require "yaml"
require "yaml/store"

class Employee_list < Parent_list
  # Конструктор
  def initialize(list_employees)
    super(list_employees)
  end

  def to_s
    s = ""
    @children_list.each_index{|i| s += "Работник - #{i}\n#{@children_list[i]}"}
    s
  end

  # Урезанный формат ФИО
  def cut_to_s
    s = ""
    @children_list.each_index{|i| s += "Работник - #{i}\n#{@children_list[i].cut}"}
    s
  end
  # Сортировка по Фамилии
  def sort_by!
    @children_list.sort_by!{|a| a.surname}
  end


  # Считывание всех отделов из файла
  def Employee_list.read_from_txt(file)
    file = File.new(file, "r")
    list_employees = [] # Список отделов
    for line in file.readlines
      list_employees.push(Employee.read_line(line))
    end
    file.close()
    new(list_employees)
  end

  # Запись всех отделов в файл
  def Employee_list.write_to_txt(file)
    File.open(file, "w") do |f|
      @children_list.each do |x|
      f.puts("#{x.surname} #{x.firstname} #{x.lastname};#{x.bd};#{x.passport};#{x.phone};#{x.address};#{x.email}")
      end
    end
  end

  def Employee_list.initialize_txt(file)
    @index = -1
    @children_list = Employee_list.read_from_txt(file)
  end


  # Метод возвращающий коллекцию, в названии которых
  # содержится введенная в аргументе строка как подстрока.
  def Employee_list.all_employees_with_substring(str)
    new(@children_list.find_all do |x|
      x.surname[str] or x.firstname[str] or x.lastname[str] or
      x.bd[str] or x.passport[str] or x.address[str] or x.phone[str] or x.email[str]
    end)
  end

  # Подсчет полного возраста
  def Employee_list.age_in_completed_years (bd, today)
    age = today.year - bd.year
    age = age - 1 if (
         bd.month >  today.month or
        (bd.month >= today.month and bd.day > today.day)
    )
    age
  end

  # Метод возвращающий людей, конкретного возраста
  def Employee_list.employees_of_a_specific_age(age)
    today = Time.new() # Текущая дата
    new(@children_list.find_all do |x|
      data = x.bd.split(".")
      Employee_list.age_in_completed_years(Time.new(data[0],
        data[1], data[2]), today) == age
    end)
  end

  # Метод  возвращающий людей, младше заданного возраста
  def Employee_list.employees_of_the_youngest_age(age)
    today = Time.new() # Текущая дата
    new(@children_list.find_all do |x|
      data = x.bd.split(".")
      Employee_list.age_in_completed_years(Time.new(data[0],
        data[1], data[2]), today) < age
    end)
  end

  # Метод  возвращающий людей, старше заданного возраста
  def Employee_list.employees_of_the_olderest_age(age)
    today = Time.new() # Текущая дата
    new(@children_list.find_all do |x|
      data = x.bd.split(".")
      Employee_list.age_in_completed_years(Time.new(data[0],
        data[1], data[2]), today) > age
    end)
  end

  # Метод  возвращающий людей в заданном диапазоне
  def Employee_list.employees_of_the_range_age(age_a, age_b)
    today = Time.new() # Текущая дата
    new(@children_list.find_all do |x|
      data = x.bd.split(".")
       Employee_list.age_in_completed_years(Time.new(data[2],
        data[1], data[0]), today) < age_b and Employee_list.age_in_completed_years(Time.new(data[2],
         data[1], data[0]), today) > age_a
    end)
  end
end
