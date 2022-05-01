path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/Salary/Salary.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

require "yaml"
require "yaml/store"

def main
  posts = Post_list.read_from_txt("#{File.dirname(__FILE__)}/car_dealership/All_posts.txt")
  # puts posts
  employees = Employee_list.read_from_txt("#{File.dirname(__FILE__)}/car_dealership/Employees.txt")
  employees.each { |x| puts x.total_salary(posts) }
end

if __FILE__ == $0
    main
end
