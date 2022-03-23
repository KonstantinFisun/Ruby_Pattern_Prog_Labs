class Department
  attr_accessor :name,:phone

  def initialize (name, phone)
  @name, @phone = name, phone
  end

  def info
    puts("#{name} : #{phone}")
  end
end

def main
  sales_department = Department.new("Отдел продаж", "+7-923-42-52-522")
  hr_department = Department.new("Отдел кадров", "+7-425-25-24-235")

  sales_department.info
  hr_department.info
end

if __FILE__ == $0
    main
end
