current_path = File.dirname(__FILE__)
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

class Department
  attr_accessor :name
  attr_reader :phone

  # Конструктор
  def initialize(name, phone, duty, posts)
  @name = name # Имя
  self.phone = phone # Телефон
  @duty = duty # Обязанности
  @posts = posts # Должности
  @index_duty = -1 # Индекс выбранной обязанности
  @index_post = -1 # Индекс выбранной должности
  end

  # Конструктор, принимающий строку
  def Department.read_line(line)
    component = line.chomp.split(';')
    new(component[0], component[1],component[2].split(','),Post_list.read_from_txt("#{File.dirname(__FILE__)}/car_dealership/" + component[3]))
  end
  #=====================================================================================================================
  # Получение информации об объекте
  def to_s
    "Название: #{@name}; Телефон : #{@phone}; \nОбязанности : \n#{duty}Должности: \n#{@posts}\n"
  end

  # Урезанный формат
  def cut
    "Название: #{@name}; Телефон : #{@phone}; Количество обязанностей : #{@duty.length}; Вакантных должностей: #{@posts.find_vacancy.length}\n"
  end

  # Вывод всех обязанностей
  def duty
    s = ""
    @duty.each_index{|i| s += "#{i} - #{@duty[i]} \n"}
    s
  end


  # Вывод всех обязанностей в txt
  def duty_write_txt
    s = ""
    @duty.each_index{|i| s += "#{@duty[i]},"}
    s.chop
  end

  # Вывод всех должностей
  def posts
    @posts.posts
  end

  # # Вывод всех должностей в txt
  def posts_write_txt(file)
    @posts.posts_write_txt(file)
  end
  #=====================================================================================================================
  # Добавить обязанность
  def duty_add(value)
    @duty.append(value)
  end

  # Выделить конкретную обязанность
  def duty_select(index)
    @index_duty = index_duty
  end

  # Удалить обязанность
  def duty_delete
    @duty.delete_at(@index_duty)
    @index_duty = -1
  end

  # Получить текст выделенной обязанности
  def get_text_sel_duty
    @duty[@index_duty]
  end

  # Заменить текст выделенной обязанности
  def change_text_sel_duty(value)
    @duty[@index_duty] = value
  end
  #=====================================================================================================================
  # Сеттер номера телефона
  # Проверка корректности номера
  def phone=(value)
    if self.class.verify_phone(value)
      @phone = value
    else raise ArgumentError.new("Номер телефона введен неверно!")
    end
  end

  # Метод класса для проверки номера телефона
  def self.verify_phone(phone)
    phone == /^((\+7|7|8)+(\d){10})$/.match(phone).to_s
  end

  #=====================================================================================================================
  # Добавить должность
  def post_add(value)
    @posts.add_note(value)
  end

  # Выбрать должность
  def post_select(index)
    @posts.choose_note(index)
  end

  # Удалить должность
  def post_delete
    @posts.delete_note
  end

  # Получить должность
  def get_sel_post
    @posts.get_note
  end

  # Изменить должность
  def change_sel_post(value)
    @posts.change_note(value)
  end
  #=====================================================================================================================

  # Все вакантные должности
  def popular_vacancies
    @posts.find_vacancy
  end

  # Количество вакантных мест
  def count_vacancy
    @posts.find_vacancy.length
  end

  #=====================================================================================================================

  # Метод, строящий Employee_list всех сотрудников, находящихся сейчас на данных должностях
  def employees_in_posts(employee_list)
    employee_list.each do |x|
      @posts.each do |y|
        if x.current_post.post_name == y.name
          x
        end
      end
    end
  end
end
