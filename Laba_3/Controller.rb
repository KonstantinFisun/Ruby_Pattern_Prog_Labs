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

  # Метод добавления
  def add
    raise NotImplementedError, "Не реализован метод добавления"
  end
end

# ======================================================================================================================
# Различные состояния
class DepState < State
  # Реализация метода отрисовки
  def draw(app,table)
    ViewDep.new(app, table)
  end

  # Реализация метода добавления
  def add(app)
    ViewDep.add_dep(app)
  end
end

class PostState < State
  # Реализация метода отрисовки
  def draw(app,table)
    ViewPost.new(app, table)
  end

  # Реализация метода добавления
  def add(sender, sel, ptr)
    ViewPost.add_dep(sender, sel, ptr)
  end
end

class JobState < State
  # Реализация метода отрисовки
  def draw(app,table)
    ViewJob.new(app, table)
  end

  # Реализация метода добавления
  def add(sender, sel, ptr)
    ViewJob.add_dep(sender, sel, ptr)
  end
end

class EmployeeState < State
  # Реализация метода отрисовки
  def draw(app,table)
    ViewEmployee.new(app, table)
  end

  # Реализация метода добавления
  def add(sender, sel, ptr)
    ViewEmployee.add_dep(sender, sel, ptr)
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
      @driver_db = DB_driver.get_instance
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
  def self.transition_to(state)
    @state = state
    @state.controller = self
  end

  #=====================================================================================================================
  # Отображение
  def self.draw(app, table)
    @state.draw(app, table)
  end
  # #===================================================================================================================
  # Добавление
  def self.add(app)
    @state.add(app)
  end
  #=====================================================================================================================
  # # Обработка данных с формы
  # def self.add_bd
  #
  # end

  # # Добавление департаментов
  # def self.add_dep(name, phone, duty, posts)
  #   puts(@application.class)
  # end
  #
  # # Добавление должностей
  # def self.add_post(department, post, salary, vacancy)
  #   puts(@application.class)
  # end
  #
  # # Добавление записи о работе
  # def self.add_job(post, employee, start_date, date_of_dismissal, percentage_bid)
  #   puts(@application.class)
  # end
  #
  # # Добавление сотрудника о работе
  # def self.add_employee(surname, firstname, lastname, bd, passport, phone, address, email)
  #   puts(@application.class)
  # end
  #=====================================================================================================================

end
