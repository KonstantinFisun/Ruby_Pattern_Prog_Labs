path = File.dirname(__FILE__) # Получили путь к папке
require "#{path}/Department.rb"

class Department_list
  # Конструктор
  def initialize(list_departments)
    @departments = list_departments
    #list_departments.each{|x| self.add_note(x)}
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

  # Считывание всех отделов из файла
  def read_from_txt(file)
    file = File.new(file, "r")
    list_departments = [] # Список отделов
    for line in file.readlines
      component = line.chomp.split(';')
      list_departments.push(d = Department.new(component[0], component[1]))
      component[2].split(',').each{|x| d.duty_add(x)} # Добавили обязанности
    end
    file.close()
    @departments = list_departments
  end

  # Запись всех отделов в файл
  def write_to_txt(file)
    File.open(file, "w") do |f|
      @departments.each{|x| f.puts("#{x.name};#{x.phone};#{x.duty_write_txt}")}
    end
  end

  # Считывание всех отделов из YAML
  def read_from_YAML(file)
    store = YAML::Store.new file
    list_departments = ""
    File.open(file, 'r') do |f|
      while (line = f.gets)
        list_departments += line
      end
    end
    store.load(list_departments)
    @departments = list_departments
  end

  # Запись всех отделов в YAML
  def write_to_yaml(file)
    File.open(file,"w") do |f|
      f.puts YAML.dump(@departments)
    end
  end

end
