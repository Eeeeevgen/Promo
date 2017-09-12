class Api::V1::ImageSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :image, :likes_count, :rank
  attribute :aasm_state, if: :owner?

  def image
    object.image.url
  end

  def rank
    LB.rank_for(object.id)
  end

  def owner?
    user = scope[:current_user] || current_user
    user && user.id == object.user_id
  end
end
