path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/Salary/Salary.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

require "yaml"
require "yaml/store"
require 'mysql2'

# Подключение базы данных
def db_mysql_con
  client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "12345", :database => "car_dealership")
end

def main
  depart = Department_list.read_from_db(db_mysql_con)
  puts(depart)
  # results = db_mysql_con.query("select * from car_dealership.department")
  # results.each do |row|
  #   puts row["name"]
  # end
  # posts = Post_list.read_from_txt("#{File.dirname(__FILE__)}/car_dealership/All_posts.txt")
  # # puts posts
  # employees = Employee_list.read_from_txt("#{File.dirname(__FILE__)}/car_dealership/Employees.txt")
  # puts(employees.sort_by_salary(posts))
  # emp = Employee_list.get_instance
end

if __FILE__ == $0
    main
end
