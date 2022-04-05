path = File.dirname(__FILE__) # Получили путь к папке
require "#{path.rpartition('/').first + '/Fine'}/Fine_percent_sal.rb"

class Premium_fine_percent_sal < Fine_percent_sal
  # Конструктор
  def initialize(fixed, allowance_in_percentage, fine, premium)
    super(fixed, allowance_in_percentage, fine)
    @premium = premium
  end

  def get_salary
    super()+(super()/100*@premium)
  end
end
