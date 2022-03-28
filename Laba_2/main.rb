path = File.dirname(__FILE__) # Получили путь к папке
require "#{path}/Department.rb"

# Считывание отделов из файла
def read_from_txt(file)
  file = File.new(file, "r")
  list_departments = [] # Список отделов
  for line in file.readlines
    component = line.chomp.split(';')
    list_departments.push(d = Department.new(component[0], component[1]))
    component[2].split(',').each{|x| d.duty_add(x)} # Добавили обязанности
  end
  list_departments
end

# Вывод всех отделов из списка
def departments_info(departments)
  departments.each{|x| puts(x)}
end


def main
  list_departments = read_from_txt("Department.txt")
  departments_info(list_departments)
end

if __FILE__ == $0
    main
end
