path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/Salary/Salary.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }


require "yaml"
require "yaml/store"



def main
  employeers = Department_list.initialize_txt("Department.txt")
  lol = employeers.class.all_departments_with_substring("про")
  puts(lol)
end

if __FILE__ == $0
    main
end
