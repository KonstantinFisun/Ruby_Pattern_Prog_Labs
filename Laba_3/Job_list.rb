path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
require "yaml"
require "yaml/store"

class Job_list < Parent_list

  # Конструктор
  def initialize(list_employees)
    super(list_employees)
  end

  #=============================================================================
  # Переопределенный метод to_s
  def to_s
    s = ""
    @children_list.each_index{|i| s += "Запись - #{i}\n#{@children_list[i]}"}
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
end
