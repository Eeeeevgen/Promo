module LeaderboardI
  class Top < LeaderboardI::BaseInteraction
    def execute
      # lb.leaders(1)
      lb.top(100)
    end
  end
end