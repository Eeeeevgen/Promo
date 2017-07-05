# $redis = Redis::Namespace.new("promo", :redis => Redis.new)

uri = URI.parse(ENV["REDIST_URL"] || "redis://localhost:6379/" )
$redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)