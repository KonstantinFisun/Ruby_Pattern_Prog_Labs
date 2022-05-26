path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/Salary/Salary.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

# Отображение должностей
class ViewEmployee
  def initialize(app, table, employee)

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
  def self.add_employee(app)

    # Создание диалогово окна
    dlg = FXDialogBox.new(app, "Добавить сотрудника")

    # Заполнение контента
    frame = FXHorizontalFrame.new(dlg, LAYOUT_FILL_X|LAYOUT_FILL_Y)
    FXLabel.new(frame, "Фамилия:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    surname = FXTextField.new(frame, 10,
                           :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXLabel.new(frame, "Имя:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    firstname = FXTextField.new(frame, 10,
                               :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXLabel.new(frame, "Отчество:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    lastname = FXTextField.new(frame, 10,
                                 :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXLabel.new(frame, "Дата рождения:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    bd = FXTextField.new(frame, 10,
                                        :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXLabel.new(frame, "Паспорт:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    passport = FXTextField.new(frame, 10,
                                     :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXLabel.new(frame, "Телефон:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    phone = FXTextField.new(frame, 10,
                                     :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXLabel.new(frame, "Адрес:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    address = FXTextField.new(frame, 10,
                                     :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXLabel.new(frame, "Email:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    email = FXTextField.new(frame, 10,
                                     :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXButton.new(frame, "Отмена", nil, dlg, FXDialogBox::ID_CANCEL,
                 FRAME_RAISED|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXButton.new(frame, "Добавить", nil, dlg, FXDialogBox::ID_ACCEPT,
                 FRAME_RAISED|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)

    # Вернет ненулевое значение при нажатие ОК
    if dlg.execute != 0
      # Обращаемся к контроллеру
      Controller.add_bd([surname.text, firstname.text, lastname.text, bd.text, passport.text, phone.text, address.text, email.text])
    end
  end
end

