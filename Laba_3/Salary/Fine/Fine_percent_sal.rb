path = File.dirname(__FILE__) # Получили путь к папке
require "#{path.rpartition('/').first}/Percent_sal.rb"

class Fine_percent_sal < Percent_sal
  # Конструктор
  def initialize(fixed, allowance_in_percentage, fine)
    super(fixed, allowance_in_percentage) # Конструкто родителя
    @fine = fine
  end

  def get_salary
    super() - @fine
  end
end
