path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/Salary/Salary.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

require "yaml"
require "yaml/store"

require 'fox16'

include Fox

class Controller
  def initialize
    @application = FXApp.new("TableApp", "FoxTest")

    # Подключение к базе данных
    begin
      @driver_db = DB_driver.get_instance
    rescue Exception
      puts("Не удалось подключиться к базе")
    end

    # Создание окна
    Table.new(@application)

    # Создание приложения
    @application.create

    # Запуск
    @application.run

  end

  # Отображение департаментов
  def self.draw_dep(app, table)
    ViewDep.new(app, table)
  end

  # Отображение должностей
  def self.draw_dep(app, table)
    ViewPost.new(app, table)
  end

  # Добавление департаментов
  def self.add_dep(name, phone, duty, posts)
    puts(@application.class)
  end
end
