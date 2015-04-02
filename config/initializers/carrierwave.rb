require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
       provider:               'AWS',
       aws_access_key_id:      Rails.application.secrets.s3_key,
       aws_secret_access_key:  Rails.application.secrets.s3_secret_key,
       region:                 'eu-west-1'
  }

  config.fog_directory  = 'wheelmart'
  config.fog_public     = true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
end
