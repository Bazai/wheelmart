class Model < ActiveRecord::Base
  belongs_to :mark
  has_many :years
end
