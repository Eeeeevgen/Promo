module LeaderboardI
  class NewImage < ActiveInteraction::Base
    integer :image_id
    integer :score, default: 0

    def execute
      LB.rank_member(image_id, score)
    end
  end
end
