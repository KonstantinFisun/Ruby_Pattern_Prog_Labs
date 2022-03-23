class Department
  attr_accessor :name, :phone

  def initialize (name, phone, *duty)
  @name, @phone = name, phone
  @duty = duty
  @index_duty = -1 # Индекс выбранной обязанности
  end
  # Получение информации об объекте
  def to_s
    "Имя: #{@name}; Телефон : #{@phone}; \n Обязанности : \n #{duty}"
  end

  # Вывод всех обязанностей
  def duty
    s = ""
    @duty.each_index{|i| s += "#{i} - #{@duty[i]} \n"}
    s
  end

  # Добавить обязанность,
  def duty_add(value)
    @duty.append(value)
  end

  # Выделить конкретную обязанность
  def duty_select(index)
    @index = index
  end

  # Удалить обязанность
  def duty_delete
    @duty.delete_at(@index)
    @index = -1
  end

  # Получить текст выделенной обязанности
  def get_text_sel_duty
    @duty[@index]
  end

  # Заменить текст выделенной обязанности
  def change_text_sel_duty(value)
    @duty[@index] = value
  end

end

def main
  sales_department = Department.new("Отдел продаж", "+7-923-42-52-522", "Привлечение клиентов")
  hr_department = Department.new("Отдел кадров", "+7-425-25-24-235", "Расчет премии", "Определение количество рабочих дней")

  # Добавление обязанностей
  sales_department.duty_add("Работа с целевой аудиторией")

  # Выбрать определенную обязанность
  sales_department.duty_select(1)

  # Заменить текст выделенной обязанности
  sales_department.change_text_sel_duty("Бездельничать")

  # Получить текст выделенной обязанности
  puts(sales_department.get_text_sel_duty)

  # Удаление обязанности
  sales_department.duty_delete

  # Вывод обязанностей
  puts(sales_department)

end

if __FILE__ == $0
    main
end
