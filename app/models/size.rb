class Size < ActiveRecord::Base
  belongs_to :mod

  validates_presence_of :width, :diameter, :bolt_count, :bolt_distance, :et, :di
  def to_s
    "#{width}x#{diameter} PCD: #{bolt_count}x#{bolt_distance} ET#{et.to_i} D#{di}"
  end
end
