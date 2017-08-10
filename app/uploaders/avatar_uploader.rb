class AvatarUploader < BaseUploader
  # Process files as they are uploaded:
  process resize_to_fit: [200, 200]

  version :thumb do
    process resize_to_fit: [64, 64]
  end

  def default_url(*args)
    # 'default_avatar.png'
    "/default_avatar.png"
  end
end
