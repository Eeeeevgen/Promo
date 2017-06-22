class User < ApplicationRecord
  mount_uploader :avatar, PictureUploader
end
