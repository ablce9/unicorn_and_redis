require 'rack'
require 'redis-store'
require './middlewares/redis'

$store = Redis::Store.new(url: ENV['REDIS_URL'] || 'redis://0.0.0.0:6379/')

app = Rack::Builder.app do
  use MyRedis
  run lambda { |env|
    [
      200,
      {'Content-Type' => 'text/plain'},
      ["counter: #{env['count']}\n"]
    ]
  }
end

run app
