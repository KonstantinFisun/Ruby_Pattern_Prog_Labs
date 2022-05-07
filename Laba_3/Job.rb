class Job
  attr_accessor :post_name,:employee,:start_date,:date_of_dismissal,:percentage_of_the_bid
  # Конструктор
  def initialize(post_name:, employee: nil, start_date:nil, date_of_dismissal:nil, percentage_bid: 50)
    @post_name = post_name
    @employee = employee
    @start_date = start_date
    @date_of_dismissal = date_of_dismissal
    @percentage_bid = percentage_bid
  end

  # Конструктор, принимающий строку
  def Job.read_line(line)
    component = line.chomp.split(';') # Разделитель в строке
    new(post_name: component[0], employee: component[1], start_date: component[2], date_of_dismissal: component[3], percentage_bid: component[4])
  end

  #=====================================================================================================================

  # Переопределение to_s
  def to_s
    "#{@post_name}, #{if @employee!= nil then "Сотрудник: #{@employee.surname} ," end} Дата назначения: #{@start_date}, Процент от ставки: #{@percentage_bid} #{if @date_of_dismissal != "" and @date_of_dismissal != nil then ", Дата увольнения: "+@date_of_dismissal end}"
  end

  # Урезанный формат
  def cut
    "#{@post_name}, Сотрудник: #{@employee.surname}"
  end
  #=====================================================================================================================

  # Метод, получающий зарплату
  def get_salary(posts)
    post = posts.find{|x| @post_name == x.name} # * @percentage_bid
    if post != nil
      post.salary.to_i * @percentage_bid.to_i/100
    else
      0
    end
  end
end
