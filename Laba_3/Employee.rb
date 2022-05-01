
class Employee
  # Геттеры и сеттеры
  attr_accessor :surname, :firstname, :lastname, :bd, :passport,
  :phone, :address, :email

  # Конструктор
  def initialize(surname:, firstname:, lastname:, bd:, passport:,
  phone:, address:, email:, job_list:nil)
    @surname = surname # Фамилия
    @firstname = firstname # Имя
    @lastname = lastname # Отчество
    @bd = bd # День рождения
    @passport = passport # Паспорт
    @phone = phone # Телефон
    @address = address # Адрес
    @email = email # Электронная почта
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
      @job_list.add_note(job)
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
  #=====================================================================================================================

  # Метод, возвращающий текущую должность
  def current_post
    @job_list.find_all do |x|
      if x.date_of_dismissal == "" or x.date_of_dismissal == nil
        x
      end
    end
  end
  #=====================================================================================================================

  # Метод, рассчитывающий суммарную зарплату данного человека на всех текущих должностях
  # Аргумент: имеющиеся должности
  def total_salary(posts)
    current_job = current_post # Получаем все текущие работы
    sum = 0
    current_job.each{|x| sum += x.get_salary(posts)}
    sum
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
