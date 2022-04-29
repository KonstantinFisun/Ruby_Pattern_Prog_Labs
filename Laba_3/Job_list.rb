path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
require "yaml"
require "yaml/store"

class Job_list < Parent_list

  # Конструктор
  def initialize(list_job)
    super(list_job)
  end

  #=============================================================================
  # Переопределенный метод to_s
  def to_s
    s = ""
    i = 0
    @children_list.each do |x|
      s += "Запись работы - #{i}\n#{x}\n"
      i += 1
    end
    s
  end

  # Урезанный формат ФИО
  def cut_to_s
    s = ""
    @children_list.each_index{|i| s += "Запись - #{i}\n#{@children_list[i].cut}"}
    s
  end
  #=============================================================================
  # Сортировка по Фамилии
  def sort_by!
    @children_list.sort_by!{|a| a.employee}
  end
  #=============================================================================
  # Сереализация
  # Запись всех отделов в файл
  def Job_list.write_to_txt(file)
    File.open(file, "w") do |f|
      @children_list.each do |x|
      f.puts("#{x.post_name};#{x.employee};#{x.start_date};#{x.date_of_dismissal};#{x.percentage_of_the_bid}")
      end
    end
  end

  #=============================================================================
  # Десериализация
  def Job_list.read_from_txt(file)
    file = File.new(file, "r")
    list_jobs = [] # Список отделов
    for line in file.readlines
      list_jobs.push(Job.read_line(line))
    end
    file.close
    new(list_jobs)
  end

  def Job_list.initialize_txt(file)
    @index = -1
    @children_list = Job_list.read_from_txt(file)
  end
  #=============================================================================
end
