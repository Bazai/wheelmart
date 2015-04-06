# encoding: utf-8

require 'nokogiri'

require './config/environment'

ActiveRecord::Base.logger = Logger.new(STDOUT)

desc 'Parse catalog'
task :parse_catalog do
  env = ENV['RAILS_ENV'] || 'development'

  f = File.open("#{Rails.root}/lib/ostkolrad.xml")
  doc = Nokogiri::XML(f)
  f.close

  all_count = 0
  parsed = 0

  _name = '\"(?<name>.+)'
  _width = '(?<width>[1-9][0-9]?([,,.][0-9]{1,2})?)[J, ]?'
  _radius = '(?<radius>[1-9][0-9]{,2})'
  _bolt_count = '(?<bolt_count>\d)'
  _bolt_distance = '(?<bolt_distance>\d{1,3}(,\d{1,3})?)?.*'
  _et = '(ET|ЕТ)\-?(?<et>[0-9][0-9]?([,,.][0-9]{1,2})?)'
  _diameter = '((d|D)\-?(?<diameter>(\d{1,3}(,\d{1,2})?)|PLY|PSY|S|XL|L))?'
  _color = '(?<color>.*)'
  pattern = /#{_name} +#{_width}[x,х]#{_radius}.+#{_bolt_count}\/ ?#{_bolt_distance} +((#{_et} +#{_diameter})|(#{_diameter} +#{_et}))#{_color}\"/

  doc.xpath('//product').each do |product|
    _name = product.at_xpath('name').content
    puts 'Спарсено: ' + _name
    parse = _name.match(pattern)

    if parse
      name = parse[:name]
      width = parse[:width] # Ширина
      radius = parse[:radius] # Радиус
      col_bolt = parse[:bolt_count] # Количество болтов
      vilet = parse[:et] # Вылет
      diametr = parse[:diameter] # Диаметр
      bolt_rass = parse[:bolt_distance] || '' # Расстояние между болтами
      color = parse[:color]
      price = product.at_xpath('price').content.gsub("'", '').gsub('"', '').to_f

      parsed += 1

      params = {width: width.gsub(',', '.').to_f, diameter_diska: radius.gsub(',', '.').to_f, bolt_count: col_bolt.to_i, bolt_distance: bolt_rass.gsub(',', '.').to_f, et: vilet.gsub(',', '.').to_f}
      params[:price] = price
      params[:color] = color

      puts 'Название: ' + name
      puts 'Ширина: ' + width
      puts 'Радиус: ' + radius
      puts 'Количество болтов: ' + col_bolt
      puts 'Расстояние между болтами: ' + bolt_rass
      puts 'Вылет: ' + vilet
      puts 'Цена: ' + price.to_s

      if diametr
        puts 'Диаметр: ' + diametr
        params[:diameter] = diametr.gsub(',', '.').to_f
      end

      brand = Brand.find_or_create_by name: name
      params[:brand_id] = brand.id

      new_price = params[:price]
      params.delete(:price)

      disk = Disk.find_by(params)
      if disk
        disk.price = new_price
        disk.save
      end
    else
      puts 'Не спарсено' + _name
    end

    all_count += 1
  end

  puts
  puts "Всего наименований - #{all_count}"
  puts "Спарсено - #{parsed}"
  puts "Не спарсено - #{all_count - parsed}"
end