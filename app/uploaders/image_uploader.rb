class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :fog

  def store_dir
    'images'
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  process resize_to_fill: [424, 424]

  version :middle do
    process resize_to_fill: [253, 253]
  end

  version :small do
    process resize_to_fill: [80, 80]
  end

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end

