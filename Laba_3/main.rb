path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/Salary/Salary.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }


require "yaml"
require "yaml/store"



def main
  employeers = Post_list.initialize_txt("Должности.txt")
  otdel = employeers.class.all_posts_of_the_department_with_substring("ов")
  puts(otdel)
end

if __FILE__ == $0
    main
end
