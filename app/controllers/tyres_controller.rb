class TyresController < ApplicationController
  def index
    price = { high: params[:price_high], low: params[:price_low] }
    @tires = Tyre.all

    @tires = @tires.where(diameter: d)  if d = params[:diameter]
    @tires = @tires.where(height: h)  if h = params[:height]
    @tires = @tires.where(width: w)  if w = params[:width]

    @tires = @tires.where(price: price[:low]..price[:high]) if price[:low]

    if params[:brands]
      brands = params[:brands].join('|')
      @tires = @tires.where("brand_name ~* ?", brands) 
    end

    logger.debug "#{@tires.count} tires found"
    render partial: 'home/tires', locals: {tires: @tires}, layout: false
  end
end
