class Parent_list
  # Конструктор
  def initialize(children_list)
    @children_list = children_list
    @index = -1
  end

  # Метод добавления записи
  def add_note(children)
    @children_list.append(children)
  end
  # Метод выделяющий запись
  def choose_note(children_list)
    if @children_list.length > index and index >= 0
      @index = index
    else raise ArgumentError.new("Индекс вышел за пределы массива!")
    end
  end

  # Заменяет выбранную запись
  def change_note(department)
    @children_list[@index] = children_list
  end

  # Метод возвращающий выбранную запись
  def get_note
    @children_list[@index]
  end

  # Метод удаляющий выбранную запись
  def delete_note
    @children_list.delete_at(@index)
    @index = -1
  end

  def each
     @children_list.each  do |dep|
       yield dep
     end
  end

  def each_index
     @children_list.each_index  do |dep|
       yield dep
     end
  end

  def find_all
     @children_list.find_all  do |dep|
       yield dep
     end
  end

  def find
    @children_list.find  do |dep|
      yield dep
    end
  end

  # Метод возвращающий количество записей
  def len
    length = 0
    @children_list.each{|x| length += 1}
    length
  end
end
