path = File.dirname(__FILE__) # Получили путь к папке
require "#{path}/Department.rb"
require "#{path}/Department_list.rb"
require "yaml"
require "yaml/store"

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

# Вывод всех отделов из списка
def departments_info(list_departments)
  list_departments.each{|x| puts(x)}
end

# Запись всех отделов в YAML
def write_to_yaml(file, list_departments)
  File.open(file,"w") do |f|
    f.puts YAML.dump(list_departments)
  end
end

# Считывание всех отделов из YAML
def read_from_YAML(file)
  store = YAML::Store.new file
  list_departments = ""
  File.open(file, 'r') do |f|
    while (line = f.gets)
      list_departments += line
    end
  end
  store.load(list_departments)
end


def main
  list_departments = read_from_YAML("Department_write.yaml")
  # departments_info(list_departments)
  departments = Department_list.new(list_departments)
  print(departments.departments[0])
  # list_departments.push(Department.new("Отдел маркетинга", "+74234252230", "Просмотр истории взаимоотношений"))
  #
  # # write_to_txt("Department.txt", list_departments)
  # write_to_yaml("Department_write.yaml", list_departments)
end

if __FILE__ == $0
    main
end
