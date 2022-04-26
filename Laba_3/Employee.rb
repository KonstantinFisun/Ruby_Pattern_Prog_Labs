class Employee
  # Геттеры и сеттеры
  attr_accessor :surname, :firstname, :lastname, :bd, :passport,
  :phone, :address, :email

  # Конструктор
  def initialize(surname:, firstname:, lastname:, bd:, passport:,
  phone:, address:, email:)
    @surname = surname # Фамилия
    @firstname = firstname # Имя
    @lastname = lastname # Отчество
    @bd = bd # День рождения
    @passport = passport # Паспорт
    @phone = phone # Телефон
    @address = address # Адрес
    @email = email # Электронная почта
  end

  # Конструктор из строки
  def Employee.read_line(line)
    component = line.chomp.split(';')
    fio = component[0].split(" ")
    new(surname:fio[0], firstname:fio[1], lastname:fio[2],
      bd:component[1], passport:component[2], phone:component[3], address:component[4],
      email:component[5])
  end

  # Получение информации об объекте
  def to_s
    "ФИО: #{@surname} #{@firstname} #{@lastname};
     Дата рождения: #{@bd};
     Паспорт: #{@passport};
     Телефон: #{@phone};
     Адрес: #{@address};
     Email: #{@email};\n"
  end

  # Урезанный формат
  def cut
    "ФИО: #{@surname} #{@name} #{@lastname};"
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
