path = File.dirname(__FILE__) # Получили путь к папке
require "#{path.rpartition('/').first}/Rub_percent_sal.rb"

class Fine_rub_percent_sal < Rub_percent_sal
  # Конструктор
  def initialize(fixed, allowance_in_percentage, allowance_in_rub, fine)
    super(fixed, allowance_in_percentage, allowance_in_rub) # Конструктор родителя
    @fine = fine
  end

  def get_salary
    super()-@fine
  end
end
