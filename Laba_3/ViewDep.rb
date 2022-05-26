path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/Salary/Salary.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

# Отображение департаментов
class ViewDep

  def initialize(app, table)

    @app = app
    # Считывание департаментов из бд
    dep = Department_list.read_from_db

    # Количество видимых ячеек
    table.visibleRows = dep.len+5
    table.visibleColumns = 8

    # Размер таблицы
    table.setTableSize(dep.len, 4)

    # Инициализация ячеек
    r = 0
    dep.each do |x|
      table.setItemText(r, 0, x.name)
      table.setItemText(r, 1, x.phone)
      table.setItemText(r, 2, x.duty)
      table.setItemText(r, 3, x.posts)
      r += 1
    end

    # Название колонок
    name_col = ["Имя", "Телефон", "Обязанности", "Должности"]
    # Инициализация названия колонок
    (0..3).each  { |c| table.setColumnText(c, name_col[c]) }

    # Инициализация названия строк
    (0..dep.len-1).each { |r| table.setRowText(r, "#{r}") }

  end

  #Добавление департамента
  def self.add_dep(app)

    # Создание диалогово окна
    dlg = FXDialogBox.new(app, "Добавить департамент")

    # Заполнение контента
    frame = FXHorizontalFrame.new(dlg, LAYOUT_FILL_X|LAYOUT_FILL_Y)
    FXLabel.new(frame, "Название департамента:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    name = FXTextField.new(frame, 10,
                           :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXLabel.new(frame, "Телефон:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    phone = FXTextField.new(frame, 10,
                            :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXLabel.new(frame, "Обязанности:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    duty = FXTextField.new(frame, 10,
                           :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXLabel.new(frame, "Должности:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    posts = FXTextField.new(frame, 10,
                            :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXButton.new(frame, "Отмена", nil, dlg, FXDialogBox::ID_CANCEL,
                 FRAME_RAISED|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXButton.new(frame, "  Добавить  ", nil, dlg, FXDialogBox::ID_ACCEPT,
                 FRAME_RAISED|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)

    # Вернет ненулевое значение при нажатие ОК
    if dlg.execute != 0
      # Обращаемся к контроллеру
      Controller.add_dep(name.text, phone.text, duty.text, posts.text)
    end

  end
end