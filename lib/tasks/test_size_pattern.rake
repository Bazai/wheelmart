desc 'Test size pattern'
task :test_size_pattern do
  _width = '(?<width>[1-9][0-9]?([,,.][0-9]{1,2})?)[J, ]?'
  _radius = '(?<radius>[1-9][0-9]{,2})'
  _bolt_count = '(?<bolt_count>\d)'
  _bolt_distance = '(?<bolt_distance>\d{1,3}(,\d{1,3})?)'
  _et = 'ET: (?<et>[0-9][0-9]?([,,.][0-9]{1,2})?)\-'
  pattern = /#{_width}[x,х]#{_radius} PCD: #{_bolt_count}[x,х]#{_bolt_distance} #{_et}/

  puts pattern

  string_to_parse = '6,5x16 PCD: 5x114,3 ET: 45-55'

  puts string_to_parse

  parse = string_to_parse.match(pattern)

  if parse
    puts 'Ширина = ' + parse[:width] # Ширина
    puts 'Радиус = ' + parse[:radius] # Радиус
    puts 'Количество болтов = ' + parse[:bolt_count] # Количество болтов
    puts 'Расстояние между болтами = ' + parse[:bolt_distance] || '' # Расстояние между болтами
    puts 'Вылет = ' + parse[:et] # Вылет
  end
end