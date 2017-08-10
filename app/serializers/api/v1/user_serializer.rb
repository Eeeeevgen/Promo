class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar, :created_at, :updated_at, :images

  # has_many :images, -> { where(aasm_staste: :accepted) }

  def avatar
    object.avatar.url
  end

  def images
    if current_user && current_user.id == object.id
      object.images.map do |image|
        Api::V1::ImageSerializer.new(image, scope: { current_user: current_user })
      end
    else
      object.images.accepted.map do |image|
        Api::V1::ImageSerializer.new(image, scope: { current_user: current_user })
      end
    end
  end
end
