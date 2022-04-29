class Job
  attr_accessor :post_name,:employee,:start_date,:date_of_dismissal,:percentage_of_the_bid
  # Конструктор
  def initialize(post_name:, employee:, start_date:, date_of_dismissal:nil, percentage_of_the_bid:)
    @post_name = post_name
    @employee = employee
    @start_date = start_date
    @date_of_dismissal = date_of_dismissal
    @percentage_of_the_bid = percentage_of_the_bid
  end

  # Конструктор, принимающий строку
  def Job.read_line(line)
    component = line.chomp.split(';') # Разделитель в строке
    new(post_name: component[0], employee: component[1], start_date: component[2], date_of_dismissal: component[3], percentage_of_the_bid: component[4])
  end

  # Переопределение to_s
  def to_s
    "#{@post_name}, Сотрудник: #{@employee}, Дата назначения: #{@start_date}, Процент от ставки: #{@percentage_of_the_bid}, Дата увольнения: #{@date_of_dismissal}"
  end

  def cut
    "#{@post_name}, Сотрудник: #{@employee}"
  end


end
