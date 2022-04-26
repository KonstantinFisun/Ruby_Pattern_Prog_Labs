path = File.dirname(__FILE__) # Получили путь к папке
require "#{path}/Post.rb"


class Post_list
  attr_accessor :posts
  # Конструктор
  def initialize(list_posts)
    @posts = list_posts
    @index = -1
  end

  # Вывод всех должностей
  def posts
    s = ""
    @posts.each_index{|i| s += "#{i} - #{@posts[i].name} \n"}
    s
  end

  def posts_write_txt
    s = ""
    @posts.each_index{|i| s += "#{@posts[i]},"}
    s.chop
  end

  def posts_write_txt(file)
    File.open(file, "w") do |f|
      @posts.each_index{|i| f.puts ("#{@posts[i].write_to_txt}")}
    end
  end

  # Метод добавления записи
  def add_note(post)
    @posts.push(post)
  end

  # Метод выделяющий запись
  def choose_note(index)
    if @posts.length > index and index >= 0 then
      @index = index
    else raise ArgumentError.new("Индекс вышел за пределы массива!")
    end
  end

  # Заменяет выбранную запись
  def change_note(post)
    @posts[@index] = post
  end

  # Метод возвращающий выбранную запись
  def get_note
    @posts[@index]
  end

  # Метод удаляющий выбранную запись
  def delete_note
    @posts.delete_at(@index)
    @index = -1
  end

  def to_s
    s = ""
    @posts.each_index{|i| s += "Должность - #{i}\n#{@posts[i]}\n"}
    s
  end

  # Сортировка по имени
  def sort_by!
    @posts.sort_by!{|a| a.name}
  end



  # Считывание всех должностей из файла(txt)
  def Post_list.read_from_txt(file)
    file = File.new(file, "r")
    list_posts = [] # Список должностей
    for line in file.readlines
      list_posts.push(Post.read_line(line))
    end
    file.close()
    new(list_posts)
  end

  # Запись всех должностей в файл(txt)
  def Post_list.write_to_txt(file)
    File.open(file, "w") do |f|
      @posts.each{|x| f.puts("#{x.department};#{x.name};#{x.salary};#{x.vacancy}")}
    end
  end


  def each
   @posts.each  do |post|
     yield post
   end
  end

  # Считывание всех должностей из YAML
  def Post_list.read_from_yaml(file)
    store = YAML::Store.new file
    list_posts = ""
    File.open(file, 'r') do |f|
      while (line = f.gets)
        list_posts += line
      end
    end
    store.load(list_posts)
    new(list_posts)
  end

  # Запись всех должностей в YAML
  def Post_list.write_to_yaml(file)
    File.open(file,"w") do |f|
      f.puts YAML.dump(@posts)
    end
  end

  # Конструктор для yaml
  def Post_list.initialize_yaml(file)
    @index = -1
    @posts = Post_list.read_from_yaml(file)
  end

  # Конструктор для txt
  def Post_list.initialize_txt(file)
    @index = -1
    @posts = Post_list.read_from_txt(file)
  end

  # Метод получающий все вакантные должности
  def find_vacancy
    @posts.find_all{|x| x.vacancy == 1}
  end
end
