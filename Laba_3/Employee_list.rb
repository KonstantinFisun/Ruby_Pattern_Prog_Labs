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



end
