path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/Salary/Salary.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

# Отображение должностей
class ViewPost

  def initialize(app, table)

    # Считывание должностей из бд
    post = Post_list.read_from_db

    # Количество видимых ячеек
    table.visibleRows = post.len+5
    table.visibleColumns = 8

    # Размер таблицы
    table.setTableSize(post.len, 4)

    # Инициализация ячеек
    r = 0
    post.each do |x|
      table.setItemText(r, 0, x.department)
      table.setItemText(r, 1, x.name)
      table.setItemText(r, 2, x.salary.to_s)
      table.setItemText(r, 3, x.display_vacancy)
      r += 1
    end

    # Название колонок
    name_col = ["Название отдела", "Должность", "Зарплата", "Вакантность"]
    # Инициализация названия колонок
    (0..3).each  { |c| table.setColumnText(c, name_col[c]) }

    # Инициализация названия строк
    (0..post.len-1).each { |r| table.setRowText(r, "#{r}") }


  end

  #Добавление департамента
  def add_dep(sender, sel, ptr)

    # Создание диалогово окна
    dlg = FXDialogBox.new(self, "Добавить должность")

    # Заполнение контента
    frame = FXHorizontalFrame.new(dlg, LAYOUT_FILL_X|LAYOUT_FILL_Y)
    FXLabel.new(frame, "Название департамента:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    department = FXTextField.new(frame, 10,
                           :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXLabel.new(frame, "Должность:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    post = FXTextField.new(frame, 10,
                            :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXLabel.new(frame, "Зарплата:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    salary = FXTextField.new(frame, 10,
                           :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXLabel.new(frame, "Вакантность:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    vacancy = FXTextField.new(frame, 10,
                            :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXButton.new(frame, "Отмена", nil, dlg, FXDialogBox::ID_CANCEL,
                 FRAME_RAISED|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
    FXButton.new(frame, "Добавить", nil, dlg, FXDialogBox::ID_ACCEPT,
                 FRAME_RAISED|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)

    # Вернет ненулевое значение при нажатие ОК
    if dlg.execute != 0
      # Обращаемся к контроллеру
      Controller.add_post(department.text, post.text, salary.text, vacancy.text)
    end

  end
end