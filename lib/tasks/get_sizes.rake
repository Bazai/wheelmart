require 'nokogiri'
require 'open-uri'
require 'json'
require 'yaml'
require 'cgi'

require './config/environment'

ActiveRecord::Base.logger = Logger.new(STDOUT)

desc 'Get sizes'
task :get_sizes do

  # marks = {
  #     'Acura' => 'acura',
  #     'Alfa Romeo' => 'alfa romeo',
  #     'Aston Martin' => 'aston martin',
  #     'Audi' => 'audi',
  #     'Bentley' => 'bentley',
  #     'BMW' => 'bmw',
  #     'Brilliance' => 'brilliance',
  #     'Buick' => 'buick',
  #     'BYD' => 'byd',
  #     'Cadillac' => 'cadillac',
  #     'Chery' => 'chery',
  #     'Chevrolet' => 'chevrolet',
  #     'Chrysler' => 'chrysler',
  #     'Citroen' => 'citroen',
  #     'Dadi' => 'dadi',
  #     'Daewoo' => 'daewoo',
  #     'Daihatsu' => 'daihatsu',
  #     'Derways' => 'derways',
  #     'Dodge' => 'dodge',
  #     'FAW' => 'faw',
  #     'Ferrari' => 'ferrari',
  #     'Fiat' => 'fiat',
  #     'Ford' => 'ford',
  #     'Geely' => 'geely',
  #     'GMC' => 'gmc',
  #     'Great Wall' => 'great wall',
  #     'Haima' => 'haima',
  #     'Honda' => 'honda',
  #     'Hummer' => 'hummer',
  #     'Hyundai' => 'hyundai',
  #     'Infiniti' => 'infiniti',
  #     'Isuzu' => 'isuzu',
  #     'Iveco' => 'iveco',
  #     'Jaguar' => 'jaguar',
  #     'Jeep' => 'jeep',
  #     'Jiangling' => 'jiangling',
  #     'JMC' => 'jmc',
  #     'Kia' => 'kia',
  #     'Lamborghini' => 'lamborghini',
  #     'Lancia' => 'lancia',
  #     'Land Rover' => 'land rover',
  #     'Landwind' => 'landwind',
  #     'Lexus' => 'lexus',
  #     'Lifan' => 'lifan',
  #     'Lincoln' => 'lincoln',
  #     'Lotus' => 'lotus',
  #     'Maserati' => 'maserati',
  #     'Maybach' => 'maybach',
  #     'Mazda' => 'mazda',
  #     'Mercedes' => 'mercedes',
  #     'Mercury' => 'mercury',
  #     'MG' => 'mg',
  #     'Mini' => 'mini',
  #     'Mitsubishi' => 'mitsubishi',
  #     'Mosler' => 'mosler',
  #     'Nissan' => 'nissan',
  #     'Oldsmobile' => 'oldsmobile',
  #     'Opel' => 'opel',
  #     'Panoz' => 'panoz',
  #     'Peugeot' => 'peugeot',
  #     'Plymouth' => 'plymouth',
  #     'Pontiac' => 'pontiac',
  #     'Porsche' => 'porsche',
  #     'Ram' => 'ram',
  #     'Renault' => 'renault',
  #     'Rolls Royce' => 'rolls royce',
  #     'Rover' => 'rover',
  #     'Saab' => 'saab',
  #     'Saleen' => 'saleen',
  #     'Saturn' => 'saturn',
  #     'Scion' => 'scion',
  #     'Seat' => 'seat',
  #     'Skoda' => 'skoda',
  #     'Smart' => 'smart',
  #     'Ssang Yong' => 'ssang yong',
  #     'Subaru' => 'subaru',
  #     'Suzuki' => 'suzuki',
  #     'Toyota' => 'toyota',
  #     'Volkswagen' => 'volkswagen',
  #     'Volvo' => 'volvo',
  #     'Xin Kai' => 'xin kai',
  #     'ZAZ' => 'zaz',
  #     'ZX' => 'zx',
  #     'ВАЗ' => 'ваз',
  #     'ГАЗ' => 'газ',
  #     'ТагАЗ' => 'тагаз',
  #     'УАЗ' => 'уаз'
  # }


  # _width = '(?<width>[1-9][0-9]?([,,.][0-9]{1,2})?)[J, ]?'
  # _radius = '(?<radius>[1-9][0-9]{,2})'
  # _bolt_count = '(?<bolt_count>\d)'
  # _bolt_distance = '(?<bolt_distance>\d{1,3}(,\d{1,3})?)'
  # _et = 'ET: (?<et>[0-9][0-9]?([,,.][0-9]{1,2})?)\-'
  # pattern = /#{_width}[x,х]#{_radius} PCD: #{_bolt_count}[x,х]#{_bolt_distance} #{_et}/


  Size.delete_all
  TyreSize.delete_all
  Mark.all.each do |mark|
    mark.models.each do |model|
      model.years.each do |year|
        year.mods.each do |mod|
          url = URI.parse('http://www.allrad.ru/ru/ajax/autosize/')
          response = Net::HTTP.post_form(url, { "mfg" => mark.name, "model" => model.name, "year" => year.year, "modification" => mod.name,  "catalog" => "disc"})

          result = JSON.parse(response.body)['result'].gsub(/[\t\r\n]/,'')
          doc = Nokogiri::HTML(result)
          # disc_url = doc.search('a').first.attribute('href').value
          disc_url = doc.search('a').select{|a| CGI::parse(URI.parse(a.attribute('href').value).query)['pcd'].present? }.first
          if disc_url
            disc_href = disc_url.attribute('href').value
            disc_params = CGI::parse(URI.parse(disc_href).query)
            # byebug
            mod.sizes.new({
              width: disc_params["width[min]"].first.to_f,
              diameter: disc_params["diameter"].first.to_f,
              bolt_count: disc_params["pcd"].first.scan(/(\d)x/).first.first.to_i,
              bolt_distance: disc_params["pcd"].first.scan(/\dx(.*)/).first.first.to_f,
              et: disc_params["et[min]"].first.to_f,
              di: disc_params["dia[min]"].first.to_f,
            })
          end

          tyre_url = doc.search('a').select { |a| CGI::parse(URI.parse(a.attribute('href').value).query)['profile'].present? }.first
          if tyre_url
            tyre_href = tyre_url.attribute('href').value
            tyre_params = CGI::parse(URI.parse(tyre_href).query)

            mod.tyre_sizes.new({
              diameter: tyre_params["diameter"].first.to_f,
              height: tyre_params["profile"].first.to_f,
              width: tyre_params["width"].first.to_f,
            })
          end
          mod.save!

          puts "Марка: #{mark.name}, модель: #{model.name}, год: #{year.year}, мод: #{mod.name}"
          puts 'Диск'
          puts mod.sizes
          puts 'Шина'
          puts mod.tyre_sizes
        end
      end
    end
  end
end