path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/Salary/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/Salary/Fine/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/Salary/Premium/*.rb'].each {|file| require file }
require "yaml"
require "yaml/store"




def main
  # Проверка класса Salary в Post
  post = Post.new("1","2",Salary.new(3000),1)
  # puts(post.salary)

  puts(post.salary.get_salary)

  # p = Premium_fine_sal.new(5000, 1000, 13)
  # puts(p.get_salary)
  # rub = Fine_rub_percent_sal.new(5000, 50, 2000, 3000)
  # puts(rub.get_salary)

  # rub = Percent_sal.new(5000, 50)
  # puts(rub.get_salary)

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
