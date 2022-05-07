Dir[File.dirname(__FILE__) + '/Salary.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }
class Post
  # Геттеры и сеттеры
  attr_accessor :department, :name
  attr_reader :vacancy

  # Конструктор
  def initialize(department:,name:,salary:, percent: 0 , rub: 0, premium: 0, fine: 0,vacancy:)
    @department, @name, self.vacancy = department, name, vacancy.to_i
    set_salary(salary:salary.to_i, percent:percent.to_i, rub:rub.to_i, premium:premium.to_i, fine:fine.to_i) # Вызов сеттер зарплаты
  end

  # Конструктор, принимающий строку
  def Post.read_line(line)
    component = line.chomp.split(';') # Разделитель в строке
    salary = component[2].split(',') # Разделитель в зарплате
    new(department:component[0], name:component[1], salary:salary[0],
      percent:salary[1].to_i, rub:salary[2].to_i,premium:salary[3].to_i,fine:salary[4].to_i, vacancy:component[3])
  end

  #=============================================================================

  # Сеттер зарплаты
  # зарплата, процент надбавки, надбавка в рублях, премия в процентах, штраф
  def set_salary(salary:, percent: 0, rub: 0, premium: 0, fine: 0)
    if self.class.check_salary(salary,percent,rub,premium,fine)
      @salary = Salary.assembling(salary: salary, percent: percent, rub: rub, premium: premium, fine: fine)
    else raise ArgumentError.new("Некорректная зарплата!")
    end
  end

  # Проверка зарплаты
  def Post.check_salary(salary, percent, rub, premium, fine)
    if salary > 0 and percent >= 0 and percent <= 100 and rub >= 0 and premium >= 0 and premium <= 100 and fine >= 0
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
    if @vacancy == 0
      "не вакантна"
    else
      "вакантна"
    end
  end

  #========================================================================

  # Переопределенный метод to_s
  def to_s
    "#{@department}; Название: #{@name}; Зарплата: #{@salary}; Должность: #{display_vacancy}"
  end

  # Запись в txt
  def write_to_txt
    "#{@department};#{@name};#{@salary.write_to_txt};#{@vacancy}"
  end

  #========================================================================

  # Метод принятия на должность
  def hiring(employee, percentage_bid)
    today = Time.new # Текущая дата
    # Работа
    job = Job.new(post_name: @name, employee: "#{employee.surname} #{employee.firstname} #{employee.lastname}",
                  start_date:"#{today.day}.#{today.month}.#{today.year}",
                  date_of_dismissal:nil, percentage_bid: percentage_bid)
    employee.hiring(job) # Вызов добавления работы у сотрудника
  end

  # Метод уволить с работы
  def dismiss(employee)
    today = Time.new # Текущая дата
    # Работа
    job = Job.new(post_name: @name, employee: "#{employee.surname} #{employee.firstname} #{employee.lastname}",
                  date_of_dismissal:"#{today.day}.#{today.month}.#{today.year}")
    employee.dismiss(job) # Вызов удаления работы у сотрудника
  end
  #========================================================================

  # Метод, строящий всех сотрудников на этой должности
  # Аргумент: Employee_list
  def employees_in_post(employee_list)
    employee_list.find_all{|x| x.current_post.post_name == @name}
  end
end
