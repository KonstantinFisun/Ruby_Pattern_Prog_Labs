path = File.dirname(__FILE__) # Получили путь к папке
require "#{path}/Salary.rb"

class Fix_sal < Salary
  # Конструктор
  def initialize(fixed)
    @fixed = fixed
  end

  def get_salary
    @fixed
  end
end
