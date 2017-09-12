require 'leaderboard'

uri = URI.parse(ENV['REDIS_URL'] || 'redis://localhost:6379/')
REDIS = Redis.new(host: uri.host, port: uri.port, password: uri.password)

LB = Leaderboard.new('likes',
                     Leaderboard::DEFAULT_OPTIONS.merge(page_size: 6),
                     redis_connection: REDIS)
