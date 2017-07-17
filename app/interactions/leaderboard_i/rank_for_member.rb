module LeaderboardI
  class RankForMember < LeaderboardI::BaseInteraction
    integer :image_id

    def execute
      lb.rank_for(image_id)
    end
  end
end