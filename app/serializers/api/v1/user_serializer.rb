module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :name, :avatar, :created_at, :updated_at, :images

      def avatar
        object.avatar.url
      end

      def images
        collection = if current_user && current_user.id == object.id
                       object.images
                     else
                       object.images.accepted
                     end

        collection.map do |image|
          Api::V1::ImageSerializer.new(image, scope: { current_user: current_user })
        end
      end
    end
  end
end
