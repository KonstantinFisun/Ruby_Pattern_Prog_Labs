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

class Skilled_employee < Employee
  # Геттеры и сеттеры
  attr_accessor :experience, :description_experience

  # Конструктор
  def initialize(surname:, firstname:, lastname:, bd:, passport:,
  phone:, address:, email:, experience:, description_experience:)
  super(surname:surname, firstname:firstname, lastname:lastname, bd:bd,
    passport:passport, phone:phone, address:address, email:email)

  @experience = experience # Лет опыта
  @description_experience = description_experience # Описание опыта
  end
end
