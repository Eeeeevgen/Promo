# require 'competition_ranking_leaderboard'
require 'leaderboard'

uri = URI.parse(ENV['REDIS_URL'] || 'redis://localhost:6379/')
redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)

# LB = CompetitionRankingLeaderboard.new('likes',
#                                        Leaderboard::DEFAULT_OPTIONS.merge(page_size: 6),
#                                        redis_connection: redis)

LB = Leaderboard.new('likes',
                     Leaderboard::DEFAULT_OPTIONS.merge(page_size: 6),
                     redis_connection: redis)

LB.remove_members_in_score_range(0, 999999)

Image.accepted.each do |image|
  LB.rank_member(image.id, image.likes_count)
end