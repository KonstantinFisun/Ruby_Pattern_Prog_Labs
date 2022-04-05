path = File.dirname(__FILE__) # Получили путь к папке
require "#{path.rpartition('/').first}/Rub_sal.rb"

class Premium_rub_sal < Rub_sal
  # Конструктор
  def initialize(fixed, allowence, premium)
    super(fixed, allowence)
    @premium = premium
  end

  def get_salary
    super()+(super()/100*@premium)
  end
end
