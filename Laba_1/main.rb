# puts "Hello world, guys!"

def main
  name = ARGV.first.сapitalize  # Первый аргумент переводим в нужный регистр
  puts "Приветствую тебя, #{name}"
end

if __FILE__ == $0
    main
end
