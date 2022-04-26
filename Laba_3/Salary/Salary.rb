# Реализация декоратора

# Базовый класс с фиксированной зарплатой
class Salary
  # Конструктор
  def initialize(salary)
    @salary = salary
  end

  def get_salary
    @salary
  end
end

# Декоратор надбавки в денежных единицах(рублях)
class Salary::Rub
  # Конструктор
  def initialize(salary, allowance)
    @salary = salary
    @add_rub = allowance
  end

  def get_salary
    @salary.get_salary+@add_rub
  end
end

# Декоратор надбавки в процентах
class Salary::Percent
  # Конструктор
  def initialize(salary, allowance_in_percentage)
    @salary = salary
    @add_percent = allowance_in_percentage
  end

  def get_salary
    # Будет надбавка или нет(случайно)
    choose = rand(2)
    if(choose == 1)
      @salary.get_salary + (@salary.get_salary/100*@add_percent)
    else
      @salary.get_salary
    end
  end
end

# Декоратор премии
class Salary::Premium
  # Конструктор
  def initialize(salary, premium)
    @salary = salary
    @premium = premium
  end

  def get_salary
    @salary.get_salary+(@salary.get_salary/100*@premium)
  end
end

# Декоратор штрафа
class Salary::Fine
  # Конструктор
  def initialize(salary, fine)
    @salary = salary
    @fine = fine
  end

  def get_salary
    @salary.get_salary-@fine
  end
end

def main
  puts (Salary::Premium.new(Salary::Fine.new(Salary::Percent.new(
    Salary::Rub.new(Salary.new(5000),2000),
    5),3000),20).get_salary)
end

if __FILE__ == $0
    main
end
