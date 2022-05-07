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
  employees = Job_list.read_from_db(db_mysql_con)
  puts(employees)
end

if __FILE__ == $0
    main
end
