# Абстрактный класс для класса Salary
class Salary
  def Salary.assembling(salary:, percent:0, rub:0, premium:0, fine:0)
    salary = Fix_sal.new(salary)
    salary = Percent_sal.new(salary, percent)
    salary = Rub_sal.new(salary, rub)
    salary = Premium_sal.new(salary, premium)
    salary = Fine_sal.new(salary, fine)
    salary
  end

  def get_salary
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
end

# Декоратор надбавки в процентах
class Percent_sal < Salary_dec
  # Конструктор
  def initialize(salary, allowance_in_percentage)
    super(salary)
    @add_percent = allowance_in_percentage
  end

  def get_salary
    # Будет надбавка или нет(случайно)
    choose = rand(2)
    if(choose == 1)
      super + (super/100*@add_percent)
    else
      super
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
end

def main

end

if __FILE__ == $0
    main
end
