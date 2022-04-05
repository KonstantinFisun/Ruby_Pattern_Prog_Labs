path = File.dirname(__FILE__) # Получили путь к папке
require "#{path.rpartition('/').first + '/Fine'}/Fine_rub_sal.rb"

class Premium_fine_rub_sal < Fine_rub_sal
  # Конструктор
  def initialize(fixed, allowance, fine, premium)
    super(fixed, allowance, fine)
    @premium = premium
  end

  def get_salary
    super()+(super()/100*@premium)
  end
end
