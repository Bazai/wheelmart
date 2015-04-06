class Brand < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  has_many :disks
end
