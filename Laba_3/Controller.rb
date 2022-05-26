﻿path = File.dirname(__FILE__) # Получили путь к папке
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

  # Отображение должностей
  def self.draw_jobs(app, table)
    ViewJob.new(app, table)
  end

  # Отображение сотрудников
  def self.draw_employee(app, table)
    ViewEmployee.new(app, table)
  end

  # Добавление департаментов
  def self.add_dep(name, phone, duty, posts)
    puts(@application.class)
  end

  # Добавление должностей
  def self.add_post(department, post, salary, vacancy)
    puts(@application.class)
  end

  # Добавление записи о работе
  def self.add_job(post, employee, start_date, date_of_dismissal, percentage_bid)
    puts(@application.class)
  end

  def self.add_employee(surname, firstname, lastname, bd, passport, phone, address, email)
    puts(@application.class)
  end

end
