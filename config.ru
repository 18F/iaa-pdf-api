require 'bundler/setup'
require 'iaa'
require 'pry'

class CorsWrapper
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'

    [status, headers, body]
  end
end

class WhichPdftk
  def call(env)
    [200, {"Content-Type" => "text/json"}, [`which pdftk`]]
  end
end

class Pdftk
  def call(env)
    [200, {"Content-Type" => "text/json"}, [`pdftk`]]
  end
end

class FullpathPdftk
  def call(env)
    [200, {"Content-Type" => "text/json"}, [`/home/vcap/app/vendor/bundle/bin/pdftk`]]
  end
end

run Rack::URLMap.new({
  '/iaa' => CorsWrapper.new(IAA::Server),
  '/which_pdftk' => WhichPdftk.new,
  '/pdftk' => Pdftk.new,
  '/fullpath_pdftk' => FullpathPdftk.new
})
