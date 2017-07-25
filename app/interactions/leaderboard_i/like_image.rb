module LeaderboardI
  class LikeImage < ActiveInteraction::Base
    string :image_id
    object :image
    object :current_user,
           class: User,
           default: nil

    def execute
      like = Like.find_by(user_id: current_user.id, image_id: image_id)
      current_score = LB.score_for(image.id) || 0
      if like
        like.destroy
        LB.rank_member(image.id, current_score - 1)
      else
        Like.create(user_id: current_user.id, image_id: image_id)
        LB.rank_member(image.id, current_score + 1)
      end
    end
  end
end
