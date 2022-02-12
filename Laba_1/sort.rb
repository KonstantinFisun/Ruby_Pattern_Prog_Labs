def main
  puts("Здравствуйте! Выберите один из следующих методов:
    1. Cписок строк упорядочить по длине строки.
    2.
    ")
    sel = gets.chomp
    select_metod(sel)
end

def select_metod(number)
  case number
    when "1"
      puts("Cписок строк упорядоченный по длине строк - #{metod_1(init_list_str)}")
    else
      puts("Некорректный ввод!")
  end
end

def init_list_str
  #puts("Введите название файла: ")
  file = File.new("list_str.txt", "r")
  list_str = []
  for line in file.readlines
    list_str.push(line.chomp)
  end
  list_str
end

def metod_1(list_str)
  list_str.sort{|a,b| a.size <=> b.size}
end

if __FILE__ == $0
    main
end
