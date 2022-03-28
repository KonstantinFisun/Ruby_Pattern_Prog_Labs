path = File.dirname(__FILE__) # Получили путь к папке
require "#{path}/Department.rb"

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
  file = File.open(file, "w") do |f|
    list_departments.each{|x| f.puts("#{x.name};#{x.phone};#{x.duty_write_txt}")}
  end
end

# Вывод всех отделов из списка
def departments_info(departments)
  departments.each{|x| puts(x)}
end


def main
  list_departments = read_from_txt("Department.txt")
  departments_info(list_departments)

  list_departments.push(Department.new("Отдел маркетинга", "+74234252230", "Просмотр истории взаимоотношений"))

  write_to_txt("Department.txt", list_departments)
end

if __FILE__ == $0
    main
end
