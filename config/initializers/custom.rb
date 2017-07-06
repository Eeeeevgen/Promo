# require 'competition_ranking_leaderboard'
#
# def lb
#   # lb = CompetitionRankingLeaderboard.new('likes',  {:page_size => 6})
#   lb = CompetitionRankingLeaderboard.new('likes',  options, redis_connection: Redis.current)
# end
#
# def options
#   Leaderboard::DEFAULT_OPTIONS.merge(page_size: 6)
# end
#
# lb.remove_members_in_score_range(0, 9999)