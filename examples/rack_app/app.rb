require 'bundler'
Bundler.require

use RackPhantom::Middleware

get '/' do
  %q{<html><head><script>document.write("Hello World");</script></head><body></body></html>}
end