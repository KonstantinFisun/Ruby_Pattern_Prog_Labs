path = File.dirname(__FILE__) # Получили путь к папке
require "#{path.rpartition('/').first + '/Fine'}/Fine_sal.rb"

class Premium_fine_sal < Fine_sal
  # Конструктор
  def initialize(fixed, fine, premium)
    super(fixed, fine)
    @premium = premium
  end

  def get_salary
    super()+(super()/100*@premium)
  end
end
