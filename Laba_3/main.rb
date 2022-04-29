path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/Salary/Salary.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

require "yaml"
require "yaml/store"



def main
  posts = Post_list.initialize_txt("#{File.dirname(__FILE__)}/txt/Post_list.txt")
  # puts(posts)
  posts.hiring(Employee.new(surname: "Фисун", firstname: "Константин", lastname: "Сергеевич",
                           bd: "22.10.2001", passport: "0315277561", phone: "79885252599", address: "Крас", email: "mail",
                            job_list: Job_list.new(Job.new(post_name: "Бухгалтер", employee: "Фисун Константин Сергеевич",
                                                           start_date: "15.06.2015",percentage_bid: 1))), 1)
  # posts.class.write_to_txt("4.txt")
  # depart = Department_list.initialize_txt("#{File.dirname(__FILE__)}/txt/Department.txt")
  # puts(depart)
  # depart.class.write_to_txt("#{File.dirname(__FILE__)}/txt/2.txt")
  # job = Job.new(post_name: "Бухгалтер", employee: "Вася", start_date: "22.10.2021", percentage_of_the_bid: 100)
  # puts job.class

  # job_list = Job_list.initialize_txt("txt/Работы.txt")
  # puts job_list
  # job_list.class.write_to_txt("txt/3.txt")
end

if __FILE__ == $0
    main
end
