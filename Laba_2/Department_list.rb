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
end
