def main
  puts("Здравствуйте! Выберите один из следующих методов:
    1. Проверить, является ли строка палиндромом.
    2. Посчитать количество слов в строке.
    3. Найти количество различных цифр в десятичной числа.
    ")
    sel = gets.chomp
    select_metod(sel)
end

def init_str
  puts("Строку считываем с key или file?")
  sel = gets.chomp
  if(sel.downcase == "key")
    puts("Введите строку и нажмите Enter : ")
    ARGV.clear
    str = gets.chomp
  elsif(sel.downcase == "file")
    file = File.new(ARGV[2], "r")
    str = file.gets.chomp
  end
  str
end

def init_number
  puts("Введите цифру: ")
  sel = gets.chomp.to_i
end

def select_metod(number)
  case number
    when "1"
      puts("Является ли данная строка палиндромом - #{metod_1(init_str)}")
    when "2"
      puts("Количество слов в строке - #{metod_2(init_str)}")
    when "3"
      puts("Количество различных цифр в числе - #{metod_3(init_str)}")
    else
      puts("Некорректный ввод!")
  end
end

# Дана строка. Необходимо проверить, является ли она палиндромом.
def metod_1(str)
  if (str.downcase == str.reverse.downcase)
    "да"
  else
    "нет"
  end
end

# Дана строка в которой записаны слова через пробел. Необходимо
# посчитать количество слов.
def metod_2(str)
  str.split.size
end

# Дано натуральное число. Необходимо найти количество различных
# цифр в его десятичной записи.
def metod_3(str)
  # Удаляем пробелы, делаем массив, оставляем уникальные, размер
  str.strip.chars.uniq.size
end

if __FILE__ == $0
    main
end
