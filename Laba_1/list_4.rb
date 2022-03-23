def main
  puts("Здравствуйте! Выберите один из следующих методов:
    1. Вывести индексы массива в том порядке,в котором соответствующие
     им элементы образую убывающую последовательность.
    2. Необходимо найти элементы,расположенные между первым и вторым максимальным.
    3. Необходимо найти элементы,расположенные между первым и последним максимальным.
    4. Необходимо найти минимальный четный элемент.
    5. Для введенного числа построить список всех его простых делителей,
    причем если введенное число делится на простое число p в степени a , то в
    итоговом списке число p должно повторятся a раз. Результирующий список
    должен быть упорядочен по возрастанию.
    ")
    sel = gets.chomp
    select_metod(sel)
end

def init_list
  puts("Список считываем с key или file?")
  sel = gets.chomp
  if(sel.downcase == "key")
    puts("Введите список через пробел и нажмите Enter : ")
    ARGV.clear
    list = gets.chomp.split(" ")
  elsif(sel.downcase == "file")
    puts("Введите название файла: ")
    file_name = gets.chomp
    file = File.new(file_name, "r")
    list = file.gets.chomp.split(" ")
  end
  list = list.map {|i| i.to_i} # Преобразуем в массив чисел
end

def init_number
  puts("Введите цифру: ")
  sel = gets.chomp.to_i
end

def select_metod(number)
  case number
    when "1"
      puts("Полученный массив с индексами: #{metod_1(init_list)}")
    when "2"
      puts("Полученный массив : #{metod_2(init_list)}")
    when "3"
      puts("Полученный массив : #{metod_3(init_list)}")
    when "4"
      puts("Полученный элемент : #{metod_4(init_list)}")
    when "5"
      puts("Список : #{metod_5(init_number)}")
    else
      puts("Некорректный ввод!")
  end
end

=begin
Дан целочисленный массив. Вывести индексы массива в том порядке,
в котором соответствующие им элементы образую убывающую последовательность.
=end
def metod_1(list)
  list.map.with_index {|x,i|
    if list.first != x && list.last != x && list[i-1]>x then # Предыдущий больше текущего
      print(i," ") # Вывод индекса
      [x,i] # Оставили в листе и присвоили индекс
    elsif list.first != x && list.last != x && list[i+1]<x then # Следующий меньше текущего
      print(i," ") # Вывод индекса
      [x,i] # Оставили в листе и присвоили индекс
    elsif list.first == x && list[i+1]<x then # Первый элемент больше следующего
      print(i," ") # Вывод индекса
      [x,i] # Оставили в листе и присвоили индекс
    elsif list.last == x && list[i-1]>x then # Последний элемент меньше предыдущего
      puts(i," ") # Вывод индекса
      [x,i] # Оставили в листе и присвоили индекс
    end}.
    compact # убрали nil
end


=begin
Дан целочисленный массив. Необходимо найти элементы,расположенные между
первым и вторым максимальным.
=end
def metod_2(list)
  max_with_index = list.map.with_index.max(2) # Получаем два максимальных с индексами
  if(max_with_index[0][1] < max_with_index[1][1]) then
    start = max_with_index[0][1]
    lenght = max_with_index[1][1] - max_with_index[0][1] - 1
  else
    start = max_with_index[1][1]
    lenght = max_with_index[0][1] - max_with_index[1][1] - 1
  end
  list.slice(start + 1, lenght) # Выбираем подпоследовательность между ними
end

=begin
Дан целочисленный массив. Необходимо найти элементы,расположенные между
первым и последним максимальным.
=end
def metod_3(list)
  max_with_index = list.map.with_index.max(1) # Получаем последний максимальный с индексом
  list.slice(1, max_with_index[0][1]) # Выбираем подпоследовательность между ними
end

=begin
Дан целочисленный массив. Необходимо найти минимальный четный элемент.
=end
def metod_4(list)
  list.map{|x| if x % 2 == 0 then x end }.compact.min
end

=begin
Для введенного числа построить список всех его простых делителей,
причем если введенное число делится на простое число p в степени a , то в
итоговом списке число p должно повторятся a раз. Результирующий список
должен быть упорядочен по возрастанию.
=end
# Преобразование в список k = [del*], где узнаем сколько данное число num может поделиться на del без остатка
def func(num, k, del)
  if (num % del == 0)
    k.push(del)
    func(num / del, k, del)
  else
    k
  end
end

def metod_5(number)
  (2..number).select {|x| (1..x).select{|y| x % y == 0}.size == 2 && number % x == 0 }. # Выбрали простые делители
  # Преобразовали каждый элемент в список, в которой число p должно повторятся a раз
  map{|x| func(number, k = [], x)}.flatten # Сделали одномерный массив
end


if __FILE__ == $0
    main
end
