module LbHelper
  require 'competition_ranking_leaderboard'

  private
    def lb
      # lb = CompetitionRankingLeaderboard.new('likes',  {:page_size => 6})
      lb = CompetitionRankingLeaderboard.new('likes',  options, redis_connection: Redis.current)
    end

    def options
      Leaderboard::DEFAULT_OPTIONS.merge(page_size: 6)
    end
end