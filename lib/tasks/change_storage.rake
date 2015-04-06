require './config/environment'

ActiveRecord::Base.logger = Logger.new(STDOUT)

desc 'Change storage'
task :change_storage do
  Brand.all.each do |brand|
    image_path = "#{Rails.root}/public/images/brand/image/#{brand.id}/#{brand['image']}"

    if File.exists?(image_path)
      brand.image = File.open(image_path)
      brand.save
    end
  end
end
