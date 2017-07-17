module LeaderboardI
  class BaseInteraction < ActiveInteraction::Base
    require 'competition_ranking_leaderboard'

    def lb
      CompetitionRankingLeaderboard.new('likes',  options, redis_connection: Redis.current)
    end

    def options
      Leaderboard::DEFAULT_OPTIONS.merge(page_size: 6)
    end
  end
end
