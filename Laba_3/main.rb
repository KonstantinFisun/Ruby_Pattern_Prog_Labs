path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/Salary/Salary.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }


require "yaml"
require "yaml/store"




def main
  departments = Department_list.initialize_txt("1.txt")
  puts(departments)

  #departments = Department_list.write_to_txt("1.txt")
end

if __FILE__ == $0
    main
end
