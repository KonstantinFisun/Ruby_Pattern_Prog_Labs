def main
  number = ARGV[0]
  if(ARGV[1].downcase == "клавиатура")
    puts("Введите список через пробел и нажмите Enter : ")
    ARGV.clear
    list = gets.chomp.split(" ")
  elsif(ARGV[1].downcase == "файл")
    file = File.new(ARGV[2], "r")
    list = file.gets.chomp.split(" ")
  end
  list = list.map {|i| i.to_i} # Преобразуем в массив чисел
  select_metod(number, list)
end

def select_metod(number, list)
  case number
    when "1"
      puts("Сумма элементов списка - #{sum_el_in_list(list)}")
    when "2"
      puts("Произведение элементов списка - #{mul_el_in_list(list)}")
    when "3"
      puts("Минимальный элемент списка - #{min_el_in_list(list)}")
    when "4"
      puts("Максимальный элемент списка - #{max_el_in_list(list)}")
    else
      puts("Некорректный ввод!")
  end
end

# Функция нахождения суммы элементов списка
def sum_el_in_list(list)
  sum = 0
  for i in list do
    sum += i
  end
  sum
end

# Функция нахождения произведения элементов списка
def mul_el_in_list(list)
  mul = 1
  for i in list
    mul *= i
  end
  mul
end

# Функция нахождения минимального элемента списка
def min_el_in_list(list)
  min = list.first
  for i in list
    if(i < min)
      min = i
    end
  end
  min
end

# Функция нахождения максимального элемента списка
def max_el_in_list(list)
  max = list.first
  for i in list
    if(i > max)
      max = i
    end
  end
  max
end

if __FILE__ == $0
    main
end
