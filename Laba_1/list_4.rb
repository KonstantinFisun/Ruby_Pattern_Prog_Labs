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
      puts("Полученный массив с индексами: #{metod_1(list)}")
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

if __FILE__ == $0
    main
end
