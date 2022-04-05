path = File.dirname(__FILE__) # Получили путь к папке
require "#{path.rpartition('/').first}/Fix_sal.rb"

class Premium_sal < Fix_sal
  # Конструктор
  def initialize(fixed, premium)
    super(fixed)
    @premium = premium
  end

  def get_salary
    super()+(super()/100*@premium)
  end
end
