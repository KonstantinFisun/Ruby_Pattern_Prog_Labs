path = File.dirname(__FILE__) # Получили путь к папке
require "#{path}/Rub_sal.rb"

class Fine_rub_sal < Rub_sal
  # Конструктор
  def initialize(fixed, allowance, fine)
    super(fixed, allowance)
    @fine = fine
  end

  def get_salary
    super() - @fine
  end
end
