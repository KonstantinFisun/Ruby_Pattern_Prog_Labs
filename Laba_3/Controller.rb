path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/Salary/Salary.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

require "yaml"
require "yaml/store"

require 'fox16'

include Fox

class Controller
  def initialize
    begin
      # Подключение к базе данных
      @driver_db = DB_driver.get_instance
    rescue => exception
      # Ловим ошибку
      puts("#{exception.message}  ⚰️⚰️⚰️⚰️» ")
    else
      @application = FXApp.new("TableApp", "FoxTest")
      # Создание окна
      Table.new(@application)

      # Создание приложения
      @application.create

      # Запуск
      @application.run
    end
  end

  # Отображение департаментов
  def self.draw_dep(app, table)
    ViewDep.new(app, table)
  end

  # Отображение должностей
  def self.draw_posts(app, table)
    ViewPost.new(app, table)
  end

  # Добавление департаментов
  def self.add_dep(name, phone, duty, posts)
    puts(@application.class)
  end

  # Добавление должностей
  def self.add_post(department, post, salary, vacancy)
    puts(@application.class)
  end

end
