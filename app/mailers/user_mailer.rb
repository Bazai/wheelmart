# encoding: utf-8

class UserMailer < ActionMailer::Base
  default from: '<info@wheel-mart.ru>'

  def disk_mail(order)
    @name = order[:order][:name]
    @phone = order[:order][:phone]
    @item = order[:item]

    mail to: 'info@wheel-mart.ru', subject: 'Заказ с сайта!'
  end

  def tyre_mail(order)
    @name = order[:order][:name]
    @phone = order[:order][:phone]
    @item = order[:item]

    mail to: 'info@wheel-mart.ru', subject: 'Заказ с сайта!'
  end
end
