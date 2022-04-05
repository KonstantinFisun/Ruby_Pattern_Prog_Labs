path = File.dirname(__FILE__) # Получили путь к папке
require "#{path.rpartition('/').first}/Rub_percent_sal.rb"

class Premium_rub_percent_sal < Rub_percent_sal
  # Конструктор
  def initialize(fixed, allowance_in_percentage, allowance_in_rub, premium)
    super(fixed, allowance_in_percentage, allowance_in_rub)
    @premium = premium
  end

  def get_salary
    super()+(super()/100*@premium)
  end
end
