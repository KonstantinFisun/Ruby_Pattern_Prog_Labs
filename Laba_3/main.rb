path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/Salary/Salary.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

require "yaml"
require "yaml/store"
require 'fox16'

include Fox

class TableWindow < FXMainWindow

    def initialize(app)
        # Call the base class initializer first
        super(app, "Table Widget Test", :opts => DECOR_ALL)

        # Меню бар
        menubar = FXMenuBar.new(self, LAYOUT_SIDE_BOTTOM|LAYOUT_FILL_X)

        # Разделитель
        FXHorizontalSeparator.new(self, LAYOUT_SIDE_TOP|LAYOUT_FILL_X|SEPARATOR_GROOVE)

        # Contents
        contents = FXVerticalFrame.new(self, LAYOUT_SIDE_TOP|FRAME_NONE|LAYOUT_FILL_X|LAYOUT_FILL_Y)

        frame = FXVerticalFrame.new(contents,
                                    FRAME_SUNKEN|FRAME_THICK|LAYOUT_FILL_X|LAYOUT_FILL_Y, :padding => 0)

        # Table
        @table = FXTable.new(frame,
                             :opts => TABLE_COL_SIZABLE|TABLE_ROW_SIZABLE|LAYOUT_FILL_X|LAYOUT_FILL_Y,
                             :padding => 2)

        dep = Department_list.read_from_db

        @table.visibleRows = dep.len+5
        @table.visibleColumns = 8


        # Размер таблицы
        @table.setTableSize(dep.len, 4)

        # Инициализация ячеек
        r = 0
        dep.each do |x|
            @table.setItemText(r, 0, x.name)
            @table.setItemText(r, 1, x.phone)
            @table.setItemText(r, 2, x.duty)
            @table.setItemText(r, 3, x.posts)
            r += 1
        end

        # Название колонок
        name_col = ["Имя", "Телефон", "Обязанности", "Должности"]
        # Инициализация названия колонок
        (0..3).each  { |c| @table.setColumnText(c, name_col[c]) }

        # Инициализация названия колонок
        (0..dep.len-1).each { |r| @table.setRowText(r, "#{r}") }


        # Меню файла
        filemenu = FXMenuPane.new(self)
        FXMenuCommand.new(filemenu, "Выход", nil, getApp(), FXApp::ID_QUIT)
        FXMenuTitle.new(menubar, "Файл", nil, filemenu) # Название


        # Меню манипуляции
        manipmenu = FXMenuPane.new(self)
        FXMenuCommand.new(manipmenu, "Удалить строчку\tCtl-R", nil,
                          @table, FXTable::ID_DELETE_ROW)
        FXMenuCommand.new(manipmenu, "Вставить строчку\tCtl-Shift-R", nil,
                          @table, FXTable::ID_INSERT_ROW)
        FXMenuTitle.new(menubar, "Манипуляция", nil, manipmenu)

    end

    # Resize the table
    def on_сmd_resize_table(sender, sel, ptr)
        # Create an empty dialog box
        dlg = FXDialogBox.new(self, "Resize Table")

        # Set up its contents
        frame = FXHorizontalFrame.new(dlg, LAYOUT_FILL_X|LAYOUT_FILL_Y)
        FXLabel.new(frame, "Rows:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
        rows = FXTextField.new(frame, 5,
                               :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
        FXLabel.new(frame, "Columns:", nil, LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
        cols = FXTextField.new(frame, 5,
                               :opts => JUSTIFY_RIGHT|FRAME_SUNKEN|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
        FXButton.new(frame, "Cancel", nil, dlg, FXDialogBox::ID_CANCEL,
                     FRAME_RAISED|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)
        FXButton.new(frame, "  OK  ", nil, dlg, FXDialogBox::ID_ACCEPT,
                     FRAME_RAISED|FRAME_THICK|LAYOUT_SIDE_LEFT|LAYOUT_CENTER_Y)

        # Initialize the text fields' contents
        oldnr, oldnc = @table.numRows, @table.numColumns
        rows.text = oldnr.to_s
        cols.text = oldnc.to_s

        # FXDialogBox#execute will return non-zero if the user clicks OK
        if dlg.execute != 0
            nr, nc = rows.text.to_i, cols.text.to_i
            nr = 0  if nr < 0
            nc = 0  if nc < 0
            @table.setTableSize(nr, nc)
            (0...nr).each { |r|
                (0...nc).each { |c|
                    #         @table.setItemText(r, c, "r:#{r+1} c:#{c+1}")
                }
            }
        end
        1
    end

    # Создание и показ приложения
    def create
        super
        show(PLACEMENT_SCREEN)
    end
end


if __FILE__ == $0
    # Создание приложения
    application = FXApp.new("TableApp", "FoxTest")

    # Создание окна
    TableWindow.new(application)

    # Создание приложения
    application.create

    # Запуск
    application.run
end