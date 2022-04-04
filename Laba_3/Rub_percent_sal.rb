path = File.dirname(__FILE__) # Получили путь к папке
require "#{path}/Percent_sal.rb"

class Rub_percent_sal < Percent_sal
  # Конструктор
  def initialize(fixed, allowance_in_percentage, allowance_in_rub)
    super(fixed, allowance_in_percentage) # Конструктор родителя
    @add_rub = allowance_in_rub
  end

  def get_salary
    super()+@add_rub
  end
end
