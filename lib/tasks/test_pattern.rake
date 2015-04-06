desc 'Test pattern'
task :test_pattern do
  _name = '\"(?<name>.+)'
  _width = '(?<width>[1-9][0-9]?([,,.][0-9]{1,2})?)[J, ]?'
  _radius = '(?<radius>[1-9][0-9]{,2})'
  _bolt_count = '(?<bolt_count>\d)'
  _bolt_distance = '(?<bolt_distance>\d{1,3}(,\d{1,3})?)?.*'
  _et = '(ET|ЕТ)\-?(?<et>[0-9][0-9]?([,,.][0-9]{1,2})?)'
  _diameter = '((d|D)\-?(?<diameter>(\d{1,3}(,\d{1,2})?)|PLY|PSY|S|XL|L))?'
  pattern = /#{_name} +#{_width}[x,х]#{_radius}.+#{_bolt_count}\/#{_bolt_distance} +((#{_et} +#{_diameter})|(#{_diameter} +#{_et}))/

  puts pattern

  if "\"TSW TANAKA 8,0x17 5/114,3 ET35 d-76 Hyper Sil (1780TAN355114S76)".match(pattern)
    puts 'right true'
  end

  string_to_parse = "\"143145 Borbet CA 6,5x15 5/112 ET47 d72,5 MF kristallsilber"

  puts string_to_parse

  parse = string_to_parse.match(pattern)

  if parse
    puts 'Ширина = ' + parse[:width] # Ширина
    puts 'Радиус = ' + parse[:radius] # Радиус
    puts 'Количество болтов = ' + parse[:bolt_count] # Количество болтов
    puts 'Расстояние между болтами = ' + parse[:bolt_distance] || '' # Расстояние между болтами
    puts 'Вылет = ' + parse[:et] # Вылет
    puts 'Диаметр = ' + parse[:diameter] # Диаметр
  end
end