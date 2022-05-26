path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/Salary/Salary.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

# Отображение должностей
class ViewEmployee
  def initialize(app, table)

    # Считывание должностей из бд
    employee = Employee_list.read_from_db

    # Количество видимых ячеек
    table.visibleRows = employee.len+5
    table.visibleColumns = 8

    # Размер таблицы
    table.setTableSize(employee.len, 8)

    r = 0
    employee.each do |x|
      table.setItemText(r, 0, x.surname)
      table.setItemText(r, 1, x.firstname)
      table.setItemText(r, 2, x.lastname)
      table.setItemText(r, 3, x.bd)
      table.setItemText(r, 4, x.passport)
      table.setItemText(r, 5, x.phone)
      table.setItemText(r, 6, x.address)
      table.setItemText(r, 7, x.email)
      r += 1
    end

    # Название колонок
    name_col = ["Фамилия", "Имя", "Отчество", "Дата рождения", "Паспорт", "Телефон", "Адрес", "Email"]
    # Инициализация названия колонок
    (0..7).each  { |c| table.setColumnText(c, name_col[c]) }

    # Инициализация названия строк
    (0..employee.len-1).each { |r| table.setRowText(r, "#{r}") }
  end

  #Добавление департамента
  def add_employee(sender, sel, ptr)

    # Создание диалогово окна
    dlg = FXDialogBox.new(self, "Добавить сотрудника")

    # Заполнение контента
    frame = FXHorizontalFrame.new(dlg, LAYOUT_FILL_X|LAYOUT_FILL_Y)
    FXLabel.new(frame, "Должность:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    post = FXTextField.new(frame, 10,
                           :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXLabel.new(frame, "Сотрудник:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    employee = FXTextField.new(frame, 10,
                               :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXLabel.new(frame, "Дата назначения:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    start_date = FXTextField.new(frame, 10,
                                 :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXLabel.new(frame, "Дата увольнения:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    date_of_dismissal = FXTextField.new(frame, 10,
                                        :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXLabel.new(frame, "Ставка:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    percentage_bid = FXTextField.new(frame, 10,
                                     :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXButton.new(frame, "Отмена", nil, dlg, FXDialogBox::ID_CANCEL,
                 FRAME_RAISED|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXButton.new(frame, "Добавить", nil, dlg, FXDialogBox::ID_ACCEPT,
                 FRAME_RAISED|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)

    # Вернет ненулевое значение при нажатие ОК
    if dlg.execute != 0
      # Обращаемся к контроллеру
      Controller.add_job(post.text, employee.text, start_date.text, date_of_dismissal.text, percentage_bid.text)
    end
  end
end

