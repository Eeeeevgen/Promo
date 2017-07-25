module LeaderboardI
  class ClearAll < ActiveInteraction::Base
    def execute
      LB.remove_members_in_score_range(0, 9999)
    end
  end
end
