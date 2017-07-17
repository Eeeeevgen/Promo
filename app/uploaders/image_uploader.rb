class ImageUploader < BaseUploader
  # Process files as they are uploaded:
  process :resize_to_limit => [800, 800]

  version :thumb do
    process resize_to_fit: [200,133]
  end
  #
  # def to_avatar
  #   process resize_to_fit: [100,100]
  # end
end
