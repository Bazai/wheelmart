require 'spreadsheet'

desc 'Reload tires from catalogue'
task :reload_tires do 
  Tyre.delete_all
  cat = Spreadsheet.open "#{Rails.root}/lib/cat_27012015.xls"
  sheet = cat.worksheet 0

  sheet.each 1 do |row|
    if Tyre.create full_name: row[1], price: row[5], season: row[8], brand_name: row[9], name: row[10], diameter: row[11], width: row[12], height: row[13], spikes: row[14], speed: row[15]
      print '.'
    else
      print "F: #{row.idx}"
    end
  end
  puts "#{Tyre.count} tires created"
end
