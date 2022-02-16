def main
  puts("Здравствуйте! Выберите один из следующих методов:
    1. Cписок строк упорядочить по длине строки.
    2. Cписок строк упорядочить по количеству слов в строке.
    3. Отсортировать строки в порядке увеличения разницы между
    средним количеством согласных и средним количеством гласных букв в строке.
    4.
    ")
    # sel = gets.chomp
    # select_metod(sel)
    puts mean_vowel("ilya kakashka and lox")
end

def select_metod(number)
  case number
    when "1"
      puts("Cписок строк упорядоченный по длине строк - #{metod_1(init_list_str)}")
    when "2"
      puts("Cписок строк упорядоченный по количеству слов - #{metod_2(init_list_str)}")
    when "3"
      puts(" В порядке увеличения разницы между средним количеством
согласных и средним количеством гласных букв в строке - #{metod_3(init_list_str)}")
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

# Упорядочить по длине строки
def metod_1(list_str)
  list_str.sort{|a,b| a.size <=> b.size}
end

# Упорядочить по количеству слов в строке.
def metod_2(list_str)
  list_str.sort{|a,b| a.split.size <=> b.split.size}
end

# Отсортировать строки в порядке увеличения разницы между средним количеством
# согласных и средним количеством гласных букв в строке
def metod_3(list_str)
  list_str.sort{|a,b| (mean_vowel(a)-mean_vowel(a)) <=> (mean_vowel(b)-mean_vowel(b))}
end

# Среднее количество гласных
def mean_vowel(str)
  (str.size)/(str.count "qwrtplkjhgfdsmnbvcxz")
end

# Среднее количество согласных
def mean_vowel(str)
  (str.size)/(str.count "eyuioa")
end
if __FILE__ == $0
    main
end
