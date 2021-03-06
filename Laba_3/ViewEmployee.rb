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
      Controller.add_db([surname.text, firstname.text, lastname.text, bd.text, passport.text, phone.text, address.text, email.text])
    end
  end

  def self.delete(app, table)

    form = FXDialogBox.new(app, "Удалить запись")

    frame = FXHorizontalFrame.new(form, LAYOUT_FILL_X|LAYOUT_FILL_Y)
    FXLabel.new(frame, "Удалить сотрудника #{table.getItemText(table.currentRow,0)} #{table.getItemText(table.currentRow,1)}
                #{table.getItemText(table.currentRow,2)}?", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)

    FXButton.new(frame, "Отмена", nil, form, FXDialogBox::ID_CANCEL,
                 FRAME_RAISED|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXButton.new(frame, "Удалить", nil, form, FXDialogBox::ID_ACCEPT,
                 FRAME_RAISED|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)


    if form.execute != 0
      list = []
      (0..7).each{|x| list.append(table.getItemText(table.currentRow,x))}
      Controller.delete_from_db([list])
      # Удаляется выбранная строчка
      table.removeRows(table.currentRow)
    end
  end

  #Добавление департамента
  def self.update(app, table)

    # Создание диалогово окна
    dlg = FXDialogBox.new(app, "Обновить сотрудника сотрудника")

    # Заполнение контента
    frame = FXHorizontalFrame.new(dlg, LAYOUT_FILL_X|LAYOUT_FILL_Y)
    FXLabel.new(frame, "Фамилия:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    surname = FXTextField.new(frame, 10,
                              :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    surname.text = table.getItemText(table.currentRow,0)

    FXLabel.new(frame, "Имя:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    firstname = FXTextField.new(frame, 10,
                                :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    firstname.text = table.getItemText(table.currentRow,1)

    FXLabel.new(frame, "Отчество:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    lastname = FXTextField.new(frame, 10,
                               :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    lastname.text = table.getItemText(table.currentRow,2)

    FXLabel.new(frame, "Дата рождения:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    bd = FXTextField.new(frame, 10,
                         :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    bd.text = table.getItemText(table.currentRow,3)

    FXLabel.new(frame, "Паспорт:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    passport = FXTextField.new(frame, 10,
                               :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    passport.text = table.getItemText(table.currentRow,4)

    FXLabel.new(frame, "Телефон:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    phone = FXTextField.new(frame, 10,
                            :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    phone.text = table.getItemText(table.currentRow,5)

    FXLabel.new(frame, "Адрес:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    address = FXTextField.new(frame, 10,
                              :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    address.text = table.getItemText(table.currentRow,6)

    FXLabel.new(frame, "Email:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    email = FXTextField.new(frame, 10,
                            :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    email.text = table.getItemText(table.currentRow,7)

    FXButton.new(frame, "Отмена", nil, dlg, FXDialogBox::ID_CANCEL,
                 FRAME_RAISED|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXButton.new(frame, "Обновить", nil, dlg, FXDialogBox::ID_ACCEPT,
                 FRAME_RAISED|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)

    # Вернет ненулевое значение при нажатие ОК
    if dlg.execute != 0
      # Обращаемся к контроллеру
      Controller.update_db([surname.text, firstname.text, lastname.text, bd.text, passport.text, phone.text, address.text, email.text])
    end
  end
end

