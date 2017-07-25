module LeaderboardI
  class RankForMember < ActiveInteraction::Base
    integer :image_id

    def execute
      LB.rank_for(image_id)
    end
  end
end
