require 'rack_phantom/version'
require 'phantomjs'

module RackPhantom
  BOTS = [
      'AdsBot-Google',
      'Baiduspider',
      'Googlebot',
      'Googlebot-Mobile',
      'Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)',
      'Mozilla/5.0 (compatible; Ask Jeeves/Teoma; +http://about.ask.com/en/docs/about/webmasters.shtml)'
  ]

  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, response = @app.call(env)

      return [status, headers, response] unless render?(headers, env)

      response = response.join("\n").gsub("\"", "\\\"")
      html = Phantomjs.run(render_js, %["#{response}"]).strip
      headers['Content-Length'] = html.length.to_s

      [status, headers, [html]]
    end

    private

    def render_js
      File.expand_path(File.join(File.dirname(__FILE__), '..', 'js', 'render.js'))
    end

    def render?(headers, env)
      html_response?(headers) && bot?(env) && get?(env)
    end

    def html_response?(headers)
      headers['Content-Type'].include? 'text/html'
    end

    def get?(env)
      env['REQUEST_METHOD'] == 'GET'
    end

    def bot?(env)
      BOTS.include? env['HTTP_USER_AGENT']
    end
  end
end


require 'rack_phantom/railtie' if defined?(Rails)