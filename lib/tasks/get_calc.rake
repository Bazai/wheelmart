require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'yaml'
require 'cgi'

require './config/environment'


ActiveRecord::Base.logger = Logger.new(STDOUT)

desc 'Get calc'
task :get_calc do

  Mark.delete_all
  Model.delete_all
  Year.delete_all
  Mod.delete_all
  # Mark.destroy_all
  # Model.destroy_all
  # Year.destroy_all
  # Mod.destroy_all

  marks = {
      'Acura' => 'acura',
      'Alfa Romeo' => 'alfa romeo',
      'Aston Martin' => 'aston martin',
      'Audi' => 'audi',
      'Bentley' => 'bentley',
      'BMW' => 'bmw',
      'Brilliance' => 'brilliance',
      'Buick' => 'buick',
      'BYD' => 'byd',
      'Cadillac' => 'cadillac',
      'Chery' => 'chery',
      'Chevrolet' => 'chevrolet',
      'Chrysler' => 'chrysler',
      'Citroen' => 'citroen',
      'Dadi' => 'dadi',
      'Daewoo' => 'daewoo',
      'Daihatsu' => 'daihatsu',
      'Derways' => 'derways',
      'Dodge' => 'dodge',
      'FAW' => 'faw',
      'Ferrari' => 'ferrari',
      'Fiat' => 'fiat',
      'Ford' => 'ford',
      'Geely' => 'geely',
      'GMC' => 'gmc',
      'Great Wall' => 'great wall',
      'Haima' => 'haima',
      'Honda' => 'honda',
      'Hummer' => 'hummer',
      'Hyundai' => 'hyundai',
      'Infiniti' => 'infiniti',
      'Isuzu' => 'isuzu',
      'Iveco' => 'iveco',
      'Jaguar' => 'jaguar',
      'Jeep' => 'jeep',
      'Jiangling' => 'jiangling',
      'JMC' => 'jmc',
      'Kia' => 'kia',
      'Lamborghini' => 'lamborghini',
      'Lancia' => 'lancia',
      'Land Rover' => 'land rover',
      'Landwind' => 'landwind',
      'Lexus' => 'lexus',
      'Lifan' => 'lifan',
      'Lincoln' => 'lincoln',
      'Lotus' => 'lotus',
      'Maserati' => 'maserati',
      'Maybach' => 'maybach',
      'Mazda' => 'mazda',
      'Mercedes' => 'mercedes',
      'Mercury' => 'mercury',
      'MG' => 'mg',
      'Mini' => 'mini',
      'Mitsubishi' => 'mitsubishi',
      'Mosler' => 'mosler',
      'Nissan' => 'nissan',
      'Oldsmobile' => 'oldsmobile',
      'Opel' => 'opel',
      'Panoz' => 'panoz',
      'Peugeot' => 'peugeot',
      'Plymouth' => 'plymouth',
      'Pontiac' => 'pontiac',
      'Porsche' => 'porsche',
      'Ram' => 'ram',
      'Renault' => 'renault',
      'Rolls Royce' => 'rolls royce',
      'Rover' => 'rover',
      'Saab' => 'saab',
      'Saleen' => 'saleen',
      'Saturn' => 'saturn',
      'Scion' => 'scion',
      'Seat' => 'seat',
      'Skoda' => 'skoda',
      'Smart' => 'smart',
      'Ssang Yong' => 'ssang yong',
      'Subaru' => 'subaru',
      'Suzuki' => 'suzuki',
      'Toyota' => 'toyota',
      'Volkswagen' => 'volkswagen',
      'Volvo' => 'volvo',
      'Xin Kai' => 'xin kai',
      'ZAZ' => 'zaz',
      'ZX' => 'zx',
      'ВАЗ' => 'ваз',
      'ГАЗ' => 'газ',
      'ТагАЗ' => 'тагаз',
      'УАЗ' => 'уаз'
  }

  marks.each_pair do |k, v|
    mark = Mark.create name: k
    puts 'Get models for ' + v
    url = URI.parse('http://www.allrad.ru/ru/ajax/autosize/')
    response = Net::HTTP.post_form(url, { "mfg" => v, "catalog" => "disc"})

    JSON.parse(response.body)['model'].each do |model|
      # if model['car'] == 'Town & Country'
      #   next
      # end

      # if model['car'] == 'Qashqai+2'
      #   next
      # end

      # if model['car'] == 'Wagon R+'
      #   next
      # end

      _model = Model.create name: model['name'], mark: mark

      model_response = Net::HTTP.post_form(url, { "mfg" => v, "model" => model['name'], "catalog" => "disc"})
      puts 'Get years for ' + model['name']

      JSON.parse(model_response.body)['year'].each do |year|
        _year = Year.create year: year['name'].to_i, mark: mark, model: _model

        year_response = Net::HTTP.post_form(url, { "mfg" => v, "model" => model['name'], "year" => year['name'], "catalog" => "disc"})

        puts 'Get mods for ' + year['name'].to_s
        JSON.parse(year_response.body)['modification'].each do |mod|
          _mod = Mod.create name: mod['name'], mark: mark, model: _model, year: _year
        end
      end
    end
  end
end
