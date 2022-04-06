Dir[File.dirname(__FILE__) + '/Salary/*.rb'].each {|file| require file }
class Post
  # Геттеры и сеттеры
  attr_accessor :department, :name
  attr_reader :vacancy, :salary

  # Конструктор
  def initialize(department,name,salary = Salary.new,vacancy)
    @department, @name, self.vacancy = department, name, vacancy.to_i
    @salary = salary
  end

  # Конструктор, принимающий строку
  def Post.read_line(line)
    component = line.chomp.split(';')
    new(component[0], component[1], component[2], component[3])
  end

  # Сеттер вакансии
  def vacancy=(value)
    if self.class.check_vacancy(value)
      @vacancy = value
    else raise ArgumentError.new("Вакантность должности введена неверно!")
    end
  end

  # Сеттер зарплаты
  # def salary=(**value)
  #
  # end

  # Проверка зарплаты
  def Post.check_salary(value)

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

  # Переопределенный метод to_s
  def to_s
    "Отдел: #{department}; Название: #{name}; Оклад: #{salary}; Должность: #{display_vacancy}"
  end

end
