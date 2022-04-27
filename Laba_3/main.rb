path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/Salary/Salary.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

require "yaml"
require "yaml/store"



def main
  employeers = Employee_list.initialize_txt("Работники.txt")
  lol = employeers.class.employees_of_the_range_age(18,25)
  puts(lol)
end

if __FILE__ == $0
    main
end
