
class Employee
  # Геттеры и сеттеры
  attr_accessor :surname, :firstname, :lastname, :bd, :passport,
  :phone, :address, :email

  # Конструктор
  def initialize(surname:, firstname:, lastname:, bd:, passport:,
  phone:, address:, email:, job_list:nil)
    self.surname = surname.gsub(/\s+/, "") # Фамилия
    self.firstname = firstname.gsub(/\s+/, "") # Имя
    self.lastname = lastname.gsub(/\s+/, "") # Отчество
    @bd = bd # День рождения
    @passport = passport # Паспорт
    self.phone = phone # Телефон
    @address = address # Адрес
    self.email = email # Электронная почта
    @job_list = job_list # Места работ
  end

  # Конструктор из строки
  def Employee.read_line(line)
    component = line.chomp.split(';')
    fio = component[0].split(" ")
    new(surname:fio[0], firstname:fio[1], lastname:fio[2],
      bd:component[1], passport:component[2], phone:component[3], address:component[4],
      email:component[5], job_list: Job_list.read_from_txt("#{File.dirname(__FILE__)}/car_dealership/" + component[6]))
  end
  #=====================================================================================================================
  # Сеттеры
  # Проверка номера телефона
  def phone=(value)
    if self.class.verify_phone(value)
      @phone = ("7-"+value[1..-1]).insert(5, "-")
    else raise ArgumentError.new("Номер телефона введен неверно #{value}!")
    end
  end

  # Метод класса для проверки российского номера телефона
  def self.verify_phone(phone)
    phone.gsub!(/[^\d]/, '') # Оставили только цифры
    phone == /(8|7)[\d]{10}$/.match(phone).to_s
  end

  # Проверка email
  def email=(value)
    if self.class.verify_email(value)
      @email = value.downcase
    else raise ArgumentError.new("Электронный адрес введен неверно #{value}!")
    end
  end

  # Метод класса для проверки российского номера телефона
  def self.verify_email(email)
    email == /^((?:[a-z]+[0-9_\.-]*)+[a-z0-9_\.-]*[a-z0-9])@((?:[a-z0-9]+[\.-]*)+\.[a-z]{2,4})$/.match(email).to_s
  end

  # Проверка Фамилии, Имени и Отчества
  def surname=(value)
    if self.class.verify_name(value)
      @surname = value
    else
      raise ArgumentError.new("Фамилия введена неверно #{value}!")
    end
  end

  def firstname=(value)
    if self.class.verify_name(value)
      @firstname = value
    else raise ArgumentError.new("Имя введено неверно #{value}!")
    end
  end

  def lastname=(value)
    if self.class.verify_name(value)
      @lastname = value
    else raise ArgumentError.new("Отчество введено неверно #{value}!")
    end
  end

  # Метод класса для проверки имени
  def self.verify_name(name)
    name == /^[А-ЯЁ][а-яё]{2,}([-][А-ЯЁ][а-яё]{2,})?$/.match(name).to_s
  end

  def bd=(value)
    if self.class.verify_bd(value)
      @bd = value
    else raise ArgumentError.new("Дата рождения введена неверно #{value}!")
    end
  end

  # Метод класса для проверки даты рождения
  def self.verify_bd(birthday)
    birthday == /0?[1-9]+\.[0-9]{2}\.[0-9]{2,4}/.match(birthday).to_s
  end

  #=====================================================================================================================

  # Получение информации об объекте
  def to_s
    "ФИО: #{@surname} #{@firstname} #{@lastname};
     Дата рождения: #{@bd};
     Паспорт: #{@passport};
     Телефон: #{@phone};
     Адрес: #{@address};
     Email: #{@email};
     Список работ:\n#{@job_list}"
  end

  # Урезанный формат
  def cut
    "ФИО: #{@surname} #{@name} #{@lastname};"
  end

  #=====================================================================================================================

  # Метод вступления в должность
  def hiring(job)
    # Если не имелась работы до этого
    if @job_list == nil
      @job_list = Job_list.new([job])
    else
      if total_bid.to_i+job.percentage_bid.to_i<=150
        @job_list.add_note(job)
      else
        Exception.new("Суммарная ставка превышает заданной нормы!")
      end
    end
  end

  # Метод ухода с должности
  def dismiss(job)
    # Находим работу у сотрудника и устанавливаем дату удаления
    @job_list.each do |x|
      if x.post_name == job.post_name
        x.date_of_dismissal = job.date_of_dismissal
      end
    end
  end

  # Метод, возвращающий текущую должность
  def current_post
    @job_list.find_all do |x|
      if x.date_of_dismissal == "" or x.date_of_dismissal == nil
        x
      end
    end
  end
  #=====================================================================================================================

  # Метод, рассчитывающий суммарную зарплату данного работника на всех текущих должностях
  # Аргумент: имеющиеся должности
  def total_salary(posts)
    current_job = current_post # Получаем все текущие работы
    sum = 0
    current_job.each{|x| sum += x.get_salary(posts)}
    sum
  end

  # Метод получающий суммарную ставку работники
  def total_bid
    current_job = current_post # Получаем все текущие работы
    total = 0
    current_job.each {|x| total += x.percentage_bid}
    total
  end
end

class Skilled_employee < Employee
  # Геттеры и сеттеры
  attr_accessor :experience, :description_experience

  # Конструктор
  def initialize(surname:, firstname:, lastname:, bd:, passport:,
                  phone:, address:, email:, job_list:, experience:, descrip_exp:)
    super(surname:surname, firstname:firstname, lastname:lastname, bd:bd,
          passport:passport, phone:phone, address:address, email:email, job_list:job_list)

      @experience = experience # Лет опыта
      @descrip_exp = descrip_exp # Описание опыта
  end


end
