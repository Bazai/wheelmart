class Disk < ActiveRecord::Base
  belongs_to :brand

  def old_price
    price * 1.2
  end

  def new_price
    price * 1.15
  end
end
