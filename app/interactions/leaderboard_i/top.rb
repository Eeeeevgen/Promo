module LeaderboardI
  class Top < ActiveInteraction::Base
    def execute
      # lb.leaders(1)
      LB.top(100)
    end
  end
end
