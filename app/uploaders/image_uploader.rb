class ImageUploader < BaseUploader
  # Process files as they are uploaded:
  process resize_to_limit: [800, 800]

  version :thumb do
    process resize_to_fit: [200, 133]
  end
end
