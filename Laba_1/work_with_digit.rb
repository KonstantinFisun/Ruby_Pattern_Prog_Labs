def main
  number = ARGV.first # Считываем число, поступившее программе
  puts(sum_digits_number(number))
end

def sum_digits_number(number)
  number.split('').  # разбить на отдельные буквы (получим массив однобуквенных строк - объектов класса String)
      map {|d| d.to_i }. # буквы (цифры) преобразуем в числа (получим массив чисел)
      inject{|a,b| a + b} #  суммируем
end


if __FILE__ == $0
    main
end
