class Post
  # Геттеры и сеттеры
  attr_accessor :department, :name, :salary
  attr_reader :vacancy

  # Конструктор
  def initialize(department,name,salary,vacancy)
    @department, @name, @salary, self.vacancy = department, name, salary.to_i, vacancy.to_i
  end

  # Конструктор, принимающий строку
  def Post.read_line(line)
    component = line.chomp.split(';')
    new(component[0], component[1], component[2], component[3])
  end

  def vacancy=(value)
    if self.class.check_vacancy(value)
      @vacancy = value
    else raise ArgumentError.new("Вакантность должности введена неверно!")
    end
  end

  def Post.check_vacancy(value)
    value == 0 or value == 1
  end

  def display_vacancy
    if(@vacancy == 0) then
      "не вакантна"
    else
      "вакантна"
    end
  end
  def to_s
    "Отдел: #{department}; Название: #{name}; Оклад: #{salary}; Должность: #{display_vacancy}"
  end

end
