class Year < ActiveRecord::Base
  belongs_to :mark
  belongs_to :model
  has_many :mods
end
