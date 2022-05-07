path = File.dirname(__FILE__) # Получили путь к папке
Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }


class Post_list < Parent_list
  # Конструктор
  def initialize(list_posts)
    super(list_posts)
  end

  # Вывод всех должностей
  def posts
    s = ""
    @children_list.each_index{|i| s += "#{i} - #{@children_list[i].name} \n"}
    s
  end

  # def posts_write_txt
  #   s = ""
  #   @children_list.each_index{|i| s += "#{@children_list[i]},"}
  #   s.chop
  # end

  def posts_write_txt(file)
    File.open(file, "w") do |f|
      i = 0
      @children_list.each{|x| f.puts("#{x.write_to_txt}")}
    end
  end


  def to_s
    s = ""
    i = 0
    @children_list.each do |x|
      s += "Должность - #{i}\n#{x}\n"
      i += 1
    end
    s
  end

  # Сортировка по имени
  def sort_by!
    @children_list.sort_by!{|a| a.name}
  end

  #=====================================================================================================================
  # TXT Сереализация и десереализация
  # # Считывание всех отделов из файла
  def Post_list.read_from_txt(file)
    file = File.new(file, "r")
    list_posts = [] # Список должностей
    for line in file.readlines
      list_posts.push(Post.read_line(line))
    end
    file.close
    new(list_posts)
  end

  # Запись всех должностей в файл(txt)
  def write_to_txt(file)
    File.open(file, "w") do |f|
      @children_list.each{|x| f.puts(x.write_to_txt)}
    end
  end

  #=====================================================================================================================
  # YAML Сереализация и десереализация
  # Считывание всех должностей из YAML
  def Post_list.read_from_yaml(file)
    store = YAML::Store.new file
    list_posts = ""
    File.open(file, 'r') do |f|
      while (line = f.gets)
        list_posts += line
      end
    end
    new(store.load(list_posts))
  end

  # Запись всех должностей в YAML
  def write_to_yaml(file)
    File.open(file,"w") do |f|
      f.puts YAML.dump(@children_list)
    end
  end
  #=====================================================================================================================
  # Считывание из БД
  def Post_list.read_from_db(client)
    # Считали должности
    list_posts = []
    posts = client.query("SELECT post.name as post_name,department.name as department_name,salary,vacancy FROM post
join department ON post.id_department = department.id")
    posts.each do |post|
      list_posts.push(Post.new(department: post["department_name"], salary:post["salary"], name: post["post_name"], vacancy: post["vacancy"]))
    end
    Post_list.new(list_posts)
  end
  #=====================================================================================================================
  # Метод получающий все вакантные должности
  def find_vacancy
    Post_list.new(@children_list.find_all{|x| x.vacancy == 1})
  end

  # Метод возвращающий коллекцию должностей,
  # относящихся к заданному в аргументе отделу.
  def all_posts_of_the_department(department)
    Post_list.new(@children_list.find_all{|x| x.department == department})
  end

  # Метод возвращающий коллекцию вакантных должностей,
  # относящихся к заданному в аргументе отделу.
  def all_vacant_posts_department(department)
    Post_list.new(@children_list.find_all{|x| x.department == department and x.vacancy == 1})
  end

  # Метод возвращающий коллекцию должностей, в названии которых
  # содержится введенная в аргументе строка как подстрока.
  def all_posts_substring(str)
    Post_list.new(@children_list.find_all{|x| x.department[str] or x.name[str]})
  end

  #=====================================================================================================================

  # Метод, строящий Employee_list всех сотрудников, находящихся сейчас на данных должностях
  def employees_in_posts(employee_list)
    employee_list.each do |x|
      @children_list.each do |y|
        if x.current_post.post_name == y.name
          x
        end
      end
    end
  end
end
