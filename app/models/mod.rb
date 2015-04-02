class Mod < ActiveRecord::Base
  belongs_to :mark
  belongs_to :model
  belongs_to :year

  has_many :sizes
  has_many :tyre_sizes
end
