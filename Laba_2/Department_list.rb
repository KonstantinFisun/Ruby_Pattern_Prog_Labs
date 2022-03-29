path = File.dirname(__FILE__) # Получили путь к папке
require "#{path}/Department.rb"

class Department_list
  def initialize(*list_departments)
    @departments = list_departments
  end
end
