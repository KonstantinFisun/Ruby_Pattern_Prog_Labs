path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/Salary/Salary.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }


require "yaml"
require "yaml/store"



def main
  employeers = Employee_list.initialize_txt("Работники.txt")
  puts(employeers)
  employeers.class.write_to_txt("2.txt")
end

if __FILE__ == $0
    main
end
