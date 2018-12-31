class MyRedis
  def initialize(app)
    @app = app
  end

  def call(env)
    count = $store.get('app_count') || 0
    env['count'] = count
    count = count.to_i
    count += 1
    $store.set('app_count', count)
    @app.call(env)
  end
end
