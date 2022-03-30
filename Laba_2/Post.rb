class Post
  # Геттеры и сеттеры
  attr_accessor :department, :name, :salary
  attr_reader :vacancy

  # Конструктор
  def initialize(department,name,salary,vacancy)
    @department, @name, @salary, @vacancy = department, name, salary, vacancy
  end

  def vacancy=(value)
    if self.class.check_vacancy(value)
      @vacancy = value
    else raise ArgumentError.new("Вакантность должности введена неверно!")
    end
  end

  def Post.check_vacancy(value)
    value == 0 || 1
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
