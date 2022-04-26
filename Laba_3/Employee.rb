class Employee
  # Геттеры и сеттеры
  attr_accessor :surname, :firstname, :lastname, :bd, :passport,
  :phone, :address, :email

  # Конструктор
  def initialize(surname:, firstname:, lastname:, bd:, passport:,
  phone:, address:, email:)
    @surname = surname # Фамилия
    @name = name # Имя
    @lastname = lastname # Отчество
    @bd = bd # День рождения
    @passport = passport # Пасспорт
    @phone = phone # Телефон
    @address = address # Адрес
    @email = email # Электронная почта
  end
end
