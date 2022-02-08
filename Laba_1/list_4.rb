def main
  number = ARGV[0]
  if(ARGV[1].downcase == "key")
    puts("Введите список через пробел и нажмите Enter : ")
    ARGV.clear
    list = gets.chomp.split(" ")
  elsif(ARGV[1].downcase == "file")
    file = File.new(ARGV[2], "r")
    list = file.gets.chomp.split(" ")
  end
  list = list.map {|i| i.to_i} # Преобразуем в массив чисел
  select_metod(number, list)
end

def select_metod(number, list)
  case number
    when "1"
      puts("Полученный массив с индексами: #{metod_1(list)}")
    when "2"
      puts("Полученный массив : #{metod_2(list)}")
    when "3"
      puts("Полученный массив : #{metod_3(list)}")
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

if __FILE__ == $0
    main
end
