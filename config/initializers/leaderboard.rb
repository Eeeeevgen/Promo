require 'competition_ranking_leaderboard'

uri = URI.parse(ENV['REDIST_URL'] || 'redis://localhost:6379/')
redis = Redis.new(host: uri.host, port: uri.port, password: uri.password)

LB = CompetitionRankingLeaderboard.new('likes',
                                    Leaderboard::DEFAULT_OPTIONS.merge(page_size: 6),
                                    redis_connection: redis)
