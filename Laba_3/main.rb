path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/Salary/Salary.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }


require "yaml"
require "yaml/store"



def main
  # post = Post_list.read_from_txt("Отдел кадров-должности.txt")
  # puts(post)
  departments = Department_list.initialize_txt("department.txt")
  puts(departments)

  departments = Department_list.write_to_txt("1.txt")
end

if __FILE__ == $0
    main
end
