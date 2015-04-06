class TyreSize < ActiveRecord::Base
  belongs_to :mod

  validates_presence_of :diameter, :width, :height

  def to_s
    "#{width.to_i}/#{height.to_i} R#{diameter.to_i}"
  end
end
