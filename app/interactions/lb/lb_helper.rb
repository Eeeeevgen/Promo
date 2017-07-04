module LbHelper
  require 'competition_ranking_leaderboard'

  private
    def lb
      lb = CompetitionRankingLeaderboard.new('likes',  {:page_size => 6})
    end

    def options
      Leaderboard::DEFAULT_OPTIONS.merge(page_size: 6)
    end
end