path = File.dirname(__FILE__) # Получили путь к папке
require "#{path}/Fix_sal.rb"

class Rub_sal < Fix_sal
  # Конструктор
  def initialize(fixed, allowance)
    super(fixed)
    @add_rub = allowance
  end

  def get_salary
    super()+@add_rub
  end
end
