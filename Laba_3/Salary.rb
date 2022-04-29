# Абстрактный класс для класса Salary
class Salary
  def Salary.assembling(salary:, percent:, rub:, premium:, fine:)
    salary = Fix_sal.new(salary)
    salary = Percent_sal.new(salary, percent)
    salary = Rub_sal.new(salary, rub)
    salary = Premium_sal.new(salary, premium)
    salary = Fine_sal.new(salary, fine)
    salary
  end

  def get_salary
  end

  # Переопределение to_s
  def to_s
  end

  # Запись в txt
  def write_to_txt
  end
end

# Базовый класс с фиксированной зарплатой
class Fix_sal < Salary
  def initialize(salary)
    @salary = salary
  end

  def get_salary
    @salary
  end

  # Переопределение to_s
  def to_s
    "Оклад: #{@salary}"
  end

  # Запись в txt
  def write_to_txt
    "#{@salary}"
  end
end

# Реализация декоратора
class Salary_dec < Salary
  # Конструктор
  def initialize(salary)
    @salary = salary
  end

  def get_salary
    @salary.get_salary
  end

  # Переопределение to_s
  def to_s
    @salary.to_s
  end

  # Запись в txt
  def write_to_txt
    @salary.write_to_txt
  end
end

# Декоратор надбавки в денежных единицах(рублях)
class Rub_sal < Salary_dec
  # Конструктор
  def initialize(salary, allowance)
    super(salary)
    @add_rub = allowance
  end

  def get_salary
    super+@add_rub
  end

  # Переопределение to_s
  def to_s
    if @add_rub != 0
      super + " ,Надбавка в рублях: #{@add_rub}"
    else
      super
    end
  end

  # Запись в txt
  def write_to_txt
    if @add_rub != 0
      super + ",#{@add_rub}"
    else
      super + ","
    end
  end
end

# Декоратор надбавки в процентах
class Percent_sal < Salary_dec
  # Конструктор
  def initialize(salary, allow_in_perc)
    super(salary)
    @add_percent = allow_in_perc
    @choose = rand(2)
  end

  def get_salary
    # Будет надбавка или нет(случайно)
    if @choose == 1
      super + (super/100*@add_percent)
    else
      super
    end
  end

  # Переопределение to_s
  def to_s
    if @choose == 1 and @add_percent != 0
      super + " ,Надбавки в процентах: #{@add_percent}"
    else
      super
    end
  end

  # Запись в txt
  def write_to_txt
    if @add_percent != 0 and @choose == 1
      super + ",#{@add_percent}"
    else
      super + ","
    end
  end
end

# Декоратор премии
class Premium_sal < Salary_dec
  # Конструктор
  def initialize(salary, premium)
    super(salary)
    @premium = premium
  end

  def get_salary
    super+(super/100*@premium)
  end

  # Переопределение to_s
  def to_s
    if @premium != 0
      super + " ,Премия: #{@premium}"
    else
      super
    end
  end

  # Запись в txt
  def write_to_txt
    if @premium != 0
      super + ",#{@premium}"
    else
      super + ","
    end
  end
end

# Декоратор штрафа
class Fine_sal < Salary_dec
  # Конструктор
  def initialize(salary, fine)
    super(salary)
    @fine = fine
  end

  def get_salary
    super-@fine
  end

  # Переопределение to_s
  def to_s
    if @fine != 0
      super + " ,Штраф: #{@fine}"
    else
      super
    end
  end

  # Запись в txt
  def write_to_txt
    if @fine != 0
      super + ",#{@fine}"
    else
      super + ","
    end
  end
end

def main
end

if __FILE__ == $0
    main
end
