path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/Salary/Salary.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

require "yaml"
require "yaml/store"



def main

  # job = Job.new(post_name: "Бухгалтер", employee: "Вася", start_date: "22.10.2021", percentage_of_the_bid: 100)
  # puts job.class

  job_list = Job_list.initialize_txt("txt/Работы.txt")
  puts job_list
  job_list.class.write_to_txt("txt/3.txt")
end

if __FILE__ == $0
    main
end
