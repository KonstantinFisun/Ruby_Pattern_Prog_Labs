def main

end

# Функция нахождения суммы элементов списка
def sum_el_in_list(list)
  sum = 0
  for i in list
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
      min = i
    end
  end
  max
end

if __FILE__ == $0
    main
end
