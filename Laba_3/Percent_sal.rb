path = File.dirname(__FILE__) # Получили путь к папке
require "#{path}/Fix_sal.rb"

class Percent_sal < Fix_sal
  # Конструктор
  def initialize(fixed, allowance_in_percentage)
    super(fixed)
    @add_percent = allowance_in_percentage
  end

  def get_salary
    # Будет надбавка или нет(случайно)
    choose = rand(2)
    if(choose == 1)
      super()+(super()/100*@add_percent)
    else
      super()
    end
  end
end
