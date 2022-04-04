path = File.dirname(__FILE__) # Получили путь к папке
require "#{path}/Department.rb"
require "#{path}/Department_list.rb"
require "#{path}/Post.rb"
require "#{path}/Post_list.rb"
require "#{path}/Rub_sal.rb"
require "#{path}/Percent_sal.rb"
require "yaml"
require "yaml/store"


def main
  rub = Percent_sal.new(5000, 50)
  puts(rub.get_salary)


  # rub = Rub_sal.new(5000, 100)
  # puts(rub.get_salary)

  # posts = Post_list.initialize_txt("Post_list.txt")
  # posts.class.write_to_yaml("Post_list1.yaml")
  #dep = Department.new("Отдел связи","81241683377",["звонить","доставать"],posts)
  # dep.post_select(0)
  # puts(dep.get_sel_post)
  # departments = Department_list.initialize_txt("1.txt")
  # puts(departments.cut_to_s)
  # departments = Department_list.initialize_txt("Department.txt")
  # puts(departments)
  # departments.class.write_to_txt("Department_write.txt")
  #departments.class.write_to_txt("Post_list1.yaml")
  # puts(posts)
end

if __FILE__ == $0
    main
end
