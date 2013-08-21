require 'rack_phantom/version'
require 'phantomjs'

module RackPhantom
  class App
    def initialize(app)
      @app = app
    end

    def call(env)
      status, header, response = @app.call(env)

      html = Phantomjs.run('js/render.js', %['#{response}'])
      [status, header, html]
    end
  end
end
