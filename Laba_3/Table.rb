path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/Salary/Salary.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

require 'fox16'

include Fox

class Table < FXMainWindow

  def initialize(app)
    # Call the base class initializer first
    super(app, "Департаменты", :opts => DECOR_ALL, :width => 700, :height => 350)

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
    FXMenuCommand.new(filemenu, "Департаменты").connect(SEL_COMMAND, method(:draw_dep))
    FXMenuCommand.new(filemenu, "Должности").connect(SEL_COMMAND, method(:draw_posts))
    FXMenuTitle.new(menubar, "Файл", nil, filemenu) # Название

    # Меню манипуляции
    manip = FXMenuPane.new(self)
    FXMenuCommand.new(manip, "Добавить запись")
    FXMenuCommand.new(manip, "Удалить запись")
    FXMenuTitle.new(menubar, "Манипуляция", nil, manip)

  end

  # Обращение к контроллеру для отрисовки департаментов
  def draw_dep(sender, sel, ptr)
    Controller.draw_dep(self, @table)
  end

  # Обращение к контроллеру для отрисовки департаментов
  def draw_posts(sender, sel, ptr)
    Controller.draw_posts(self, @table)
  end


  # Создание и показ приложения
  def create
    super
    #Центрирование по центру
    show(PLACEMENT_SCREEN)
  end
end
