class Mark < ActiveRecord::Base
  has_many :models
  has_many :mods
end
