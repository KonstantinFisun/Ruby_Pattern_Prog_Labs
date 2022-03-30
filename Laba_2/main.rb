path = File.dirname(__FILE__) # Получили путь к папке
require "#{path}/Department.rb"
require "#{path}/Department_list.rb"
require "#{path}/Post.rb"
require "#{path}/Post_list.rb"
require "yaml"
require "yaml/store"

# Вывод всех отделов из списка
def departments_info(list_departments)
  list_departments.each{|x| puts(x)}
end

# Для класса Department

# Считывание всех отделов из файла
def read_from_txt(file)
  file = File.new(file, "r")
  list_departments = [] # Список отделов
  for line in file.readlines
    component = line.chomp.split(';')
    list_departments.push(d = Department.new(component[0], component[1]))
    component[2].split(',').each{|x| d.duty_add(x)} # Добавили обязанности
  end
  file.close()
  list_departments
end

# Запись всех отделов в файл
def write_to_txt(file, list_departments)
  File.open(file, "w") do |f|
    list_departments.each{|x| f.puts("#{x.name};#{x.phone};#{x.duty_write_txt}")}
  end
end

# Считывание всех отделов из YAML
def read_from_yaml(file)
  store = YAML::Store.new file
  list_departments = ""
  File.open(file, 'r') do |f|
    while (line = f.gets)
      list_departments += line
    end
  end
  store.load(list_departments)
end

# Запись всех отделов в YAML
def write_to_yaml(file, list_departments)
  File.open(file,"w") do |f|
    f.puts YAML.dump(list_departments)
  end
end

#===============================================================================

def main
  posts = Post_list.initialize_txt("Post_list.txt")
  posts.class.write_to_yaml("Post_list1.yaml")
  dep = Department.new("Отдел связи","81241683377",["звонить","доставать"],posts)
  puts(dep.popular_vacancies)
  # dep.post_select(0)
  # puts(dep.get_sel_post)



  # departments = Department_list.initialize_txt("Department.txt")
  # puts(departments)
  # departments.class.write_to_txt("Department_write.txt")
  #departments.class.write_to_txt("Post_list1.yaml")

  # puts(posts)
end

if __FILE__ == $0
    main
end
