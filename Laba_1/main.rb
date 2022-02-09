# puts "Hello world, guys!"

def main
  name = ARGV.first
  puts "Приветствую тебя, #{name.capitalize}" # Первый аргумент переводим в нужный регистр
  ARGV.clear
  puts "Какой ваш любимый язык?"
  language = gets.chomp # Считываем язык
  select_language(language) # Вызов выбора ответа

  puts "Введите команду ОС"
  command_os = system"#{gets}"
  puts command_os

  puts "Введите команду Ruby"
  command_ruby = `ruby "-e#{gets}"`
  puts command_ruby
end

# Ответ на введенный язык
def select_language(language)
  case language
    when "Ruby"
      puts "Ну ты и подлиза!"
    when "C"
      puts "Это винтовка Мосина, старое, но надежное."
    when "C++"
      puts "Это нунчаки,мощные и впечатляющие в действии, но требуют годы боли, чтобы овладеть ими мастерски."
    when "Perl"
      puts "Это коктейль Молотова, однажды он был полезен, но теперь мало кто им пользуется."
    when "Scala"
      puts "Это просто вариант 240G Java, но с мануалом, написанном на непонятном диалекте."
    when "JavaScript"
      puts "Это меч без рукоятки."
    when "Go"
      puts "Это пистолет, после каждого выстрела которого нужно проверить, а правда ли он выстрелил."
    when "Rust"
      puts "Это пистолет, напечатанный на 3D принтере."
    when "C#"
      puts "Это мощная лазерная пушка, примотанная к спине осла."
    when "Lisp"
      puts "Это заточка, которая может принимать разные формы."
    else
      puts "Не понял, но скоро будет Ruby."
  end
end

if __FILE__ == $0
    main
end
