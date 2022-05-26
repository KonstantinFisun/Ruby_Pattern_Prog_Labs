path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/Salary/Salary.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

require "yaml"
require "yaml/store"

require 'fox16'

include Fox


# Абстрактный класс состояния
class State
  attr_accessor :controller

  # Метод отрисовки
  def draw
    raise NotImplementedError, "Не реализован метод отрисовки"
  end

  # Метод вывод формы добавления
  def add
    raise NotImplementedError, "Не реализован метод вывода формы добавления"
  end

  # Метод добавления в бд
  def add_bd
    raise NotImplementedError, "Не реализован метод добавления в базу данных"
  end
end

# ======================================================================================================================
# Различные состояния
class DepState < State
  # Реализация метода отрисовки
  def draw(app,table, driver_db)
    ViewDep.new(app, table, driver_db.departments_read_from_db)
  end

  # Реализация метода вывода формы добавления
  def add(app)
    ViewDep.add_dep(app)
  end

  # Реализация метода добавлени в бд
  def add_bd(list, driver_db)
    puts(list)
  end
end

class PostState < State
  # Реализация метода отрисовки
  def draw(app,table, driver_db)
    ViewPost.new(app, table, driver_db.posts_read_from_db)
  end

  # Реализация метода вывода формы добавления
  def add(app)
    ViewPost.add_post(app)
  end

  # Реализация метода добавлени в бд
  def add_bd(list, driver_db)
    puts(list)
  end
end

class JobState < State
  # Реализация метода отрисовки
  def draw(app, table, driver_db)
    ViewJob.new(app, table, driver_db.jobs_read_from_db)
  end

  # Реализация метода вывода формы добавления
  def add(app)
    ViewJob.add_job(app)
  end

  # Реализация метода добавлени в бд
  def add_bd(list, driver_db)
    puts(list)
  end
end

class EmployeeState < State
  # Реализация метода отрисовки
  def draw(app, table, driver_db)
    ViewEmployee.new(app, table, driver_db.employees_read_from_db)
  end

  # Реализация метода вывода формы добавления
  def add(app)
    ViewEmployee.add_employee(app)
  end

  # Реализация метода добавлени в бд
  def add_bd(list, driver_db)
    driver_db.employees_write_to_db(list)
  end
end
# ======================================================================================================================

class Controller
  # Ссылка на текущее состояние контроллера
  attr_accessor :state
  private :state

  def initialize
    begin
      # Подключение к базе данных
      @@driver_db = DB_driver.get_instance
    rescue => exception
      # Ловим ошибку
      puts("#{exception.message}  ⚰️⚰️⚰️⚰️» ")
    else
      @application = FXApp.new("TableApp", "FoxTest")
      # Создание окна
      Table.new(@application)


      # Переменная состояния
      @state = nil

      # Создание приложения
      @application.create

      # Запуск
      @application.run
    end
  end

  # Изменение состояния работы
  def self.transition_to(state, app, table)
    @state = state
    @state.controller = self
    self.draw(app, table)
  end

  #=====================================================================================================================
  # Отображение
  def self.draw(app, table)
    @state.draw(app, table, @@driver_db)
  end
  # #===================================================================================================================
  # Вывод формы добавление
  def self.add(app)
    @state.add(app)
  end
  #=====================================================================================================================
  # Обработка данных с формы
  def self.add_bd(list)
    @state.add_bd(list, @@driver_db)
  end
  #=====================================================================================================================

end
