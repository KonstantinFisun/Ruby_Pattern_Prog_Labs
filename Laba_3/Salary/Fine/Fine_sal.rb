path = File.dirname(__FILE__) # Получили путь к папке
require "#{path}/Fix_sal.rb"

class Fine_sal < Fix_sal
  # Конструктор
  def initialize(fixed, fine)
    super(fixed)
    @fine = fine
  end

  def get_salary
    super() - @fine
  end
end
