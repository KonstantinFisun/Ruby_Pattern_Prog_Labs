def main
  puts("Здравствуйте! Выберите один из следующих методов:
    1. Cписок строк упорядочить по длине строки.
    2. Cписок строк упорядочить по количеству слов в строке.
    3. Отсортировать строки в порядке увеличения разницы между
    средним количеством согласных и средним количеством гласных букв в строке.
    4. Отсортировать строки в порядке увеличения квадратичного отклонения частоты
встречаемости самого часто встречаемого в строке символа от частоты его
встречаемости в текстах на этом алфавите.
    5. Отсортировать строки в порядке увеличения разницы между количеством сочетаний
«гласная-согласная» и «согласная-гласная» в строке
    ")
    # sel = gets.chomp
    # select_metod(sel)
    puts(count_vowel_consonant("ilyaf lox i kozel"))
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
    when "4"
      puts("В порядке увеличения квадратичного отклонения частоты
встречаемости самого часто встречаемого в строке символа от частоты его
встречаемости в текстах на этом алфавите - #{metod_4(init_list_str)}")
    when "5"
      puts("В порядке увеличения разницы между количеством сочетаний
«гласная-согласная» и «согласная-гласная» в строке - #{metod_5(init_list_str)}")
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
  list_str.sort{|a,b| (mean_consonant(a)-mean_vowel(a)) <=> (mean_consonant(b)-mean_vowel(b))}
end

# Среднее количество согласных
def mean_consonant(str)
  (str.size)/(str.count "qwrtplkjhgfdsmnbvcxz")
end

# Среднее количество гласных
def mean_vowel(str)
  (str.size)/(str.count "eyuioa")
end

#-------------------------------------------------------------------------------

# В порядке увеличения квадратичного отклонения частоты
# встречаемости самого часто встречаемого в строке символа от частоты его
# встречаемости в текстах на этом алфавите
# 1. Найдем частоту самого часто встречающийся символ в строке
# 2. Найдем частоту этого символ в заданном тексте
# 3. Сортировка

def metod_4(list_str)
  list_str.sort{|a,b|
    ((frequency_of_the_most_frequently_occurring_character_in_line(a)
    - frequency_of_the_most_frequently_occurring_character_in_text(list_str, a))**2)<=>(
      (frequency_of_the_most_frequently_occurring_character_in_line(b)
      - frequency_of_the_most_frequently_occurring_character_in_text(list_str, b))**2)
  }
end

# Самый часто встречающийся символ в строке
def most_common_symbol(str)
  freq = Hash.new(0)
  str.gsub(/\s+/, "").chars.each { |x| freq[x] += 1 }
  # Получили ключ максимального значения и нашли его частоту встречаемости в строке:
  freq.max_by { |k, v| v }[0]
end
# Частота самого часто встречающегося символ в строке
def frequency_of_the_most_frequently_occurring_character_in_line(str)
  freq = Hash.new(0)
  str.gsub(/\s+/, "").chars.each { |x| freq[x] += 1 }
  # Получили максимальное значение и нашли его частоту встречаемости в строке:
  freq.max_by { |k, v| v }[1].to_f/str.gsub(/\s+/, "").size
end

# Частота самого часто встречающегося символа в заданном тексте
def frequency_of_the_most_frequently_occurring_character_in_text(text, str)
  freq = Hash.new(0)
  text.join('').downcase.gsub(/\s+/, "").chars.count(most_common_symbol(str)).
  to_f/text.join('').downcase.gsub(/\s+/, "").size
end

# ------------------------------------------------------------------------------

# В порядке увеличения разницы между количеством сочетаний
# «гласная-согласная» и «согласная-гласная» в строке
def metod_5(list_str)
  list_str.sort do
    |a,b| (count_vowel_consonant(a)-count_consonant_vowel(a))
    <=>
    (count_vowel_consonant(b)-count_consonant_vowel(b))
  end
end

# Количество гласная-согласная
def count_vowel_consonant(str)
  str.scan(/[eyuioa][qwrtplkjhgfdsmnbvcxz]/).size
end

# Количество согласная-гласная
def count_consonant_vowel(str)
  str.scan(/[qwrtplkjhgfdsmnbvcxz][eyuioa]/).size
end

#-------------------------------------------------------------------------------

if __FILE__ == $0
    main
end
