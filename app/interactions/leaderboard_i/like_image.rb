module LeaderboardI
  class LikeImage < LeaderboardI::BaseInteraction
    string :image_id
    object :image

    def execute
      # image = Image.find(image_id)
      like = Like.find_by(user_id: current_user.id, image_id: image_id)
      current_score = lb.score_for(image.id) || 0
      if like
        like.destroy
        lb.rank_member(image.id, current_score - 1)
      else
        Like.create(user_id: current_user.id, image_id: image_id)
        lb.rank_member(image.id, current_score + 1)
      end
    end
  end
end

