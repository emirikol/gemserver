require "rubygems"
require 'yaml'
require "geminabox"
require 'rack/request'

class KeyAuth
  def initialize(app)
    @app = app
    @paths = Set.new(%w(/api/v1/gems /upload))
    config_path = File.join(File.dirname(__FILE__), 'config', 'secrets.yml')
    config = YAML.load(File.read(config_path))[ENV['RACK_ENV'] || 'production']
    @keys = Set.new(config[:push_keys])
  end
  def call(env)
    request = Rack::Request.new(env)
    if request.POST && @paths.include?(request.path)
      if @keys.include?(request.get_header('HTTP_AUTHORIZATION'))
       @app.call(env)
      else
         content = "Bad api key #{request.get_header('HTTP_AUTHORIZATION')}, you must add #{request.base_url} to ~/.gem/credentials"
         [403, { Rack::CONTENT_TYPE => "text/plain", Rack::CONTENT_LENGTH => content.length.to_s }, [content]]
      end
    else
     @app.call(env)
    end

  end
end




Geminabox.data = "./data"
Geminabox.on_gem_received = Proc.new do |gem|
  puts "Gem received: #{gem.spec.name} #{gem.spec.version}"
end


use KeyAuth
run Geminabox::Server


