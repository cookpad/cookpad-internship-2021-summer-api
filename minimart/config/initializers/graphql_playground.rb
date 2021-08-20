GraphqlPlayground::Rails.configure do |config|
  config.headers = {
    'X-User-Name' => ->(_) { 'tomart' },
  }
  config.title = 'minimart API Playground'
  config.csrf = false
end
