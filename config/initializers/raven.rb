if Rails.env.production?
  Raven.configure do |config|
    config.dsn = 'https://7f28831b56f4499b9031dbbf21035203:78402f3546344a40900c7f946fb3c046@sentry.io/280968'
  end
end 