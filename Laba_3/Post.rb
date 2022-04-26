Dir[File.dirname(__FILE__) + '/Salary/Salary.rb'].each {|file| require file }
class Post
  # Геттеры и сеттеры
  attr_accessor :department, :name
  attr_reader :vacancy

  # Конструктор
  def initialize(department:,name:,salary:, percent: 0, rub: 0, premium: 0, fine: 0,vacancy:)
    @department, @name, self.vacancy = department, name, vacancy.to_i
    set_salary(salary:salary, percent:percent, rub:rub, premium:premium, fine:fine) # Вызов сеттер зарплаты
  end

  # Конструктор, принимающий строку
  def Post.read_line(line)
    component = line.chomp.split(';')
    new(component[0], component[1], component[2], component[3])
  end

  #=============================================================================

  # Сеттер зарплаты
  # зарплата, процент надбавки, надбавка в рублях, премия в процентах, штраф
  def set_salary(salary:, percent:, rub:, premium:, fine:)
    if self.class.check_salary(salary,percent,rub,premium,fine)
      @salary = Salary.assembling(salary: salary, percent: percent, rub: rub, premium: premium, fine: fine)
    else raise ArgumentError.new("Некорректная зарплата!")
    end
  end

  # Проверка зарплаты
  def Post.check_salary(salary, percent, rub, premium, fine)
    if(salary > 0 and percent>=0 and percent<=100 and rub>=0 and premium>=0 and premium<=100 and fine >= 0)
      true
    else
      false
    end
  end

  # Геттер зарплаты
  def salary
    @salary.get_salary
  end

  #=============================================================================

  # Сеттер вакансии
  def vacancy=(value)
    if self.class.check_vacancy(value)
      @vacancy = value
    else raise ArgumentError.new("Вакантность должности введена неверно!")
    end
  end

  # Проверка вакансии
  def Post.check_vacancy(value)
    value == 0 or value == 1
  end

  # Отображение вакансии
  def display_vacancy
    if(@vacancy == 0) then
      "не вакантна"
    else
      "вакантна"
    end
  end

  #========================================================================

  # Переопределенный метод to_s
  def to_s
    "Название: #{name}; Зарплата: #{salary}; Должность: #{display_vacancy}"
  end

  # Запись в txt
  def write_to_txt
    "#{department};#{name};#{salary};#{vacancy}"
  end

  #========================================================================

end
