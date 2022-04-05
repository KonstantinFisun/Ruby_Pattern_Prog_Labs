path = File.dirname(__FILE__) # Получили путь к папке
require "#{path.rpartition('/').first}/Percent_sal.rb"

class Premium_percent_sal < Percent_sal
  # Конструктор
  def initialize(fixed, allowance_in_percentage, premium)
    super(fixed, allowance_in_percentage)
    @premium = premium
  end

  def get_salary
    super()+(super()/100*@premium)
  end
end
