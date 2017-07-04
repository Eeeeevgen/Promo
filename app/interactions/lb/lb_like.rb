require 'active_interaction'
include LbHelper

class LbLike < ActiveInteraction::Base
  string :image_id
  object :user

  def execute
    image = Image.find(image_id)
    if user && image.user.id != user.id
      like = Like.find_by(user_id: user.id, image_id: image_id)
      current_score = lb.score_for(image.id) || 0
      if like
        like.destroy
        lb.rank_member(image.id, current_score - 1)
      else
        Like.create(user_id: user.id, image_id: image_id)
        lb.rank_member(image.id, current_score + 1)
      end
    end
  end
end