module LeaderboardI
  class Top < ActiveInteraction::Base
    def execute
      # lb.leaders(1)
      # LB.top(100)
      LB.all_leaders
    end
  end
end
