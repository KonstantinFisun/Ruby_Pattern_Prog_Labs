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


  # Считывание всех отделов из файла
  def Department_list.read_from_txt(file)
    file = File.new(file, "r")
    list_departments = [] # Список отделов
    for line in file.readlines
      list_departments.push(Department.read_line(line))
    end
    file.close()
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

  # Считывание всех отделов из YAML
  def Department_list.read_from_yaml(file)
    store = YAML::Store.new file
    list_departments = ""
    File.open(file, 'r') do |f|
      while (line = f.gets)
        list_departments += line
      end
    end
    store.load(list_departments)
    new(list_departments)
  end

  # Запись всех отделов в YAML
  def Department_list.write_to_yaml(file)
    File.open(file,"w") do |f|
      f.puts YAML.dump(@children_list)
    end
  end

  def Department_list.initialize_yaml(file)
    @index = -1
    @children_list = Department_list.read_from_yaml(file)
  end

  def Department_list.initialize_txt(file)
    @index = -1
    @children_list = Department_list.read_from_txt(file)
  end

  def sort_by_vacancy!
    @children_list.sort_by!{|a| a.count_vacancy}
  end

  # Метод возвращающий коллекцию, в названии которых
  # содержится введенная в аргументе строка как подстрока.
  def Department_list.all_departments_with_substring(str)
    new(@children_list.find_all do |x|
      x.name[str] or x.phone[str]
    end)
  end


end
