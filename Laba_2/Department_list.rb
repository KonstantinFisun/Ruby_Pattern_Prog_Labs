path = File.dirname(__FILE__) # Получили путь к папке
require "#{path}/Department.rb"
require "#{path}/Department_list.rb"
require "#{path}/Post.rb"
require "#{path}/Post_list.rb"
require "yaml"
require "yaml/store"

class Department_list
  # Конструктор
  def initialize(list_departments)
    @departments = list_departments
    @index = -1
  end



  # Метод добавления записи
  def add_note(department)
    @departments.push(department)
  end

  # Метод выделяющий запись
  def choose_note(index)
    if @departments.length > index and index >= 0 then
      @index = index
    else raise ArgumentError.new("Индекс вышел за пределы массива!")
    end
  end

  # Заменяет выбранную запись
  def change_note(department)
    @departments[@index] = department
  end

  # Метод возвращающий выбранную запись
  def get_note
    @departments[@index]
  end

  # Метод удаляющий выбранную запись
  def delete_note
    @departments.delete_at(@index)
    @index = -1
  end

  def to_s
    s = ""
    @departments.each_index{|i| s += "Отдел - #{i}\n#{@departments[i]}"}
    s
  end

  # Урезанный формат
  def cut_to_s
    s = ""
    @departments.each_index{|i| s += "Отдел - #{i}\n#{@departments[i].cut}"}
    s
  end
  # Сортировка по имени
  def sort_by!
    @departments.sort_by!{|a| a.name}
  end

  def each
   @departments.each  do |dep|
     yield dep
   end
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
      @departments.each{|x| f.puts("#{x.name};#{x.phone};#{x.duty_write_txt};#{x.posts_write_txt}")}
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
      f.puts YAML.dump(@departments)
    end
  end

  def Department_list.initialize_yaml(file)
    @index = -1
    @departments = Department_list.read_from_yaml(file)
  end

  def Department_list.initialize_txt(file)
    @index = -1
    @departments = Department_list.read_from_txt(file)
  end

  def sort_by_vacancy!
    @departments.sort_by!{|a| a.count_vacancy}
  end


end
