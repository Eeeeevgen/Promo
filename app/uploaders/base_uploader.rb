class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  include Cloudinary::CarrierWave

  # if Rails.env.production?
  #   storage :fog
  # else
  #   storage :file
  # end

  # storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
