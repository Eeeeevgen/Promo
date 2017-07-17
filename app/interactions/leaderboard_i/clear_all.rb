module LeaderboardI
  class ClearAll < LeaderboardI::BaseInteraction
    def execute
      lb.remove_members_in_score_range(0, 9999)
    end
  end
end