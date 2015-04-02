# encoding: utf-8
class HomeController < ApplicationController
  def index
    @marks = Mark.all
    @disks = Disk.all.limit(6)
    @page = Page.first
    @tires = Tyre.all.limit(6)
  end

  def load_models
    @mark = Mark.find(params[:id])
    @models = @mark.models

    render layout: false
  end

  def load_years
    @model = Model.find(params[:id])
    @years = @model.years
render layout: false
  end

  def load_mods
    @year = Year.find(params[:id])
    @mods = @year.mods

    render layout: false
  end


  def disks_by_params
    @width = params['width'] #? params['width'].to_f : nil
    @diameter_diska = params['diameter_diska'] #? params['diameter_diska'].to_f : nil
    @bolt_count = params['bolt_count'] #? params['bolt_count'].to_i : nil
    @bolt_distance = params['bolt_distance'] #? params['bolt_distance'].to_f : nil
    @et = params['et'] #? params['et'].to_f : nil
    @diameter = params['diameter'] #? params['diameter'].to_f : nil
    price = { high: params[:price_high], low: params[:price_low] }
    
    @disks = Disk.all.joins(:brand)

    unless @width.blank?
      @disks = Disk.where(width: @width)
    end

    unless @diameter_diska.blank?
      @disks = @disks.where(diameter_diska: @diameter_diska)
    end

    unless @bolt_count.blank?
      @disks = @disks.where(bolt_count: @bolt_count)
    end

    unless @bolt_distance.blank?
      @disks = @disks.where(bolt_distance: @bolt_distance)
    end

    unless @et.blank?
      @disks = @disks.where(et: @et)
    end

    unless @diameter.blank?
      @disks = @disks.where(diameter: @diameter)
    end

    if params[:brands]
      brands = params[:brands].join('|')
      @disks = @disks.where("brands.name ~* ?", brands) 
    end

    @disks = @disks.where(price: price[:low]..price[:high]) if price[:low]


    @disks = @disks.flatten.uniq.sort {|a, b|
      b[:price] <=> a[:price]
    }

    render partial: 'home/disks', locals: {disks: @disks}, layout: false
  end

  def disks
    if params[:id] && params[:id] != 'undefined'
      @mod = Mod.find(params[:id])

      if @mod.sizes

        disks = []
  
        # @diameter = ''

        # JSON.parse(@mod.sizes).each do |size|
        @mod.sizes.each do |size|
          _disks = Disk.where(
            width: [size.width.to_f-1..size.width.to_f+1],
            diameter_diska: size.diameter.to_f,
            bolt_count: size.bolt_count.to_i,
            bolt_distance: size.bolt_distance.to_f,
            et: [size.et.to_f-3..size.et.to_f+1],
            diameter: [size.di.to_f..size.di.to_f+100]
          )

          disks << _disks

          @diameter = size['diameter_stupitsi'].to_f
        end

        @disks = disks.flatten.uniq.sort {|a, b|
          b[:price] <=> a[:price]
        }

        @diameters = @disks.map(&:diameter_diska).uniq.sort

        if params[:d]
          @d = params[:d].to_f
          @disks = @disks.select{|i| i.diameter_diska == params[:d].to_f}
        end

        if @disks.empty?
          render inline: '<div class="b-selection__no-found">По вашем запросу ничего не найдено.</div>'
        else
          render partial: 'home/disks', locals: {disks: @disks, diameters: @diameters}, layout: false
        end
      else
        render inline: '<div class="b-selection__no-found">По вашем запросу ничего не найдено.</div>'
      end
    else
      render inline: '<div class="b-selection__no-found">Не верный запрос.</div>'
    end
  end

  def order
    case params[:order][:type]
    when 'tyre'
      @item = Tyre.find(params[:order][:id])
      params[:item] = @item
      UserMailer.tyre_mail(params).deliver
    else
      @item = Disk.find(params[:order][:id])
      params[:item] = @item
      UserMailer.disk_mail(params).deliver
    end

    redirect_to :back, notice: 'Спасибо! Ваша заявка принята! <br/> Наш менеджер свяжется с Вами в ближайшее время!'
  end


  def sizes_index
    @mod = Mod.find(params[:id])
    render layout: false
  end

end
