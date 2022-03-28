def main
  # sales_department = Department.new("Отдел продаж", "+79234252522", "Привлечение клиентов")
  # hr_department = Department.new("Отдел кадров", "+7423425222", "Расчет премии", "Определение количество рабочих дней")
  #
  #
  # # Добавление обязанностей
  # sales_department.duty_add("Работа с целевой аудиторией")
  #
  # # Выбрать определенную обязанность
  # sales_department.duty_select(1)
  #
  # # Заменить текст выделенной обязанности
  # sales_department.change_text_sel_duty("Бездельничать")
  #
  # # Получить текст выделенной обязанности
  # puts(sales_department.get_text_sel_duty)
  #
  # # Удаление обязанности
  # sales_department.duty_delete
  #
  # # Вывод обязанностей
  # puts(sales_department)
  # puts(hr_department)
end

if __FILE__ == $0
    main
end
