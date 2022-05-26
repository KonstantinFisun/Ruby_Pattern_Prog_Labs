path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/Salary/Salary.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

require 'fox16'

include Fox

class Table < FXMainWindow

  def initialize(app)
    # Call the base class initializer first
    super(app, "Департаменты", :opts => DECOR_ALL, :width => 1200, :height => 650)

    # Меню бар
    menubar = FXMenuBar.new(self, LAYOUT_SIDE_TOP|LAYOUT_FILL_X)

    # Разделитель
    FXHorizontalSeparator.new(self, LAYOUT_SIDE_TOP|LAYOUT_FILL_X|SEPARATOR_GROOVE)

    # Contents
    contents = FXVerticalFrame.new(self, LAYOUT_SIDE_TOP|FRAME_NONE|LAYOUT_FILL_X|LAYOUT_FILL_Y)

    frame = FXVerticalFrame.new(contents,
                                FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL_X|LAYOUT_FILL_Y, :padding => 0)


    @table = FXTable.new(frame,
                         :opts => TABLE_COL_SIZABLE|TABLE_ROW_SIZABLE|LAYOUT_FILL_X|LAYOUT_FILL_Y,
                         :padding => 2)

    # Меню файла
    filemenu = FXMenuPane.new(self)
    FXMenuCommand.new(filemenu, "Выход", nil, getApp, FXApp::ID_QUIT)
    FXMenuCommand.new(filemenu, "Департаменты").connect(SEL_COMMAND, method(:dep))
    FXMenuCommand.new(filemenu, "Должности").connect(SEL_COMMAND, method(:posts))
    FXMenuCommand.new(filemenu, "Записи о работах").connect(SEL_COMMAND, method(:jobs))
    FXMenuCommand.new(filemenu, "Сотрудники").connect(SEL_COMMAND, method(:employee))
    FXMenuTitle.new(menubar, "Файл", nil, filemenu) # Название

    # Меню манипуляции
    manip = FXMenuPane.new(self)
    FXMenuCommand.new(manip, "Добавить запись").connect(SEL_COMMAND, method(:add))
    FXMenuCommand.new(manip, "Удалить запись")
    FXMenuCommand.new(manip, "Изменить запись")
    FXMenuTitle.new(menubar, "Манипуляции", nil, manip)

  end

  # # Обращение к контроллеру для добавления записи
  def add(sender, sel, ptr)
    Controller.add(self)
  end

  # Обращение к контроллеру для изменения состояния на департаментов
  def dep(sender, sel, ptr)
    Controller.transition_to(DepState.new, self, @table) # Меняем состояние
  end

  # Обращение к контроллеру для изменения состояния на должности
  def posts(sender, sel, ptr)
    Controller.transition_to(PostState.new, self, @table) # Меняем состояние
  end

  # Обращение к контроллеру для изменения состояния на работы
  def jobs(sender, sel, ptr)
    Controller.transition_to(JobState.new, self, @table) # Меняем состояние
  end

  # Обращение к контроллеру для изменения состояния на сотрудников
  def employee(sender, sel, ptr)
    Controller.transition_to(EmployeeState.new, self, @table) # Меняем состояние
  end


  # Создание и показ приложения
  def create
    super
    #Центрирование по центру
    show(PLACEMENT_SCREEN)
  end
end
