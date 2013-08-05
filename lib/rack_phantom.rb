require 'rack_phantom/version'
require 'selenium-webdriver'

module RackPhantom
  class App
    def initialize(app)
      @app = app
    end

    def call(env)
      status, header, response = @app.call(env)
      html = `phantomjs js/render.js '#{response}'`
      [status, header, html]
    end
  end
end
