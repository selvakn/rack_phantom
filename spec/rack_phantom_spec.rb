require 'spec_helper'
require 'active_support'
require 'active_support/core_ext/object/with_options'

describe RackPhantom do

  let(:html) { %q{<html><head><script>document.write("Hello World");</script></head><body></body></html>} }
  let(:real_app) { ->(env) { [200, {}, html] } }
  let(:app) { RackPhantom::Middleware.new(real_app) }

  context 'executes javascript' do

    it 'for bots' do
      get '/', {}, as_bot
      last_response.should be_ok
      last_response.body.strip.should == evaluated_html
    end

    it 'escapes the single quotes'

    def evaluated_html
      %q{<html><head><script>document.write("Hello World");</script></head><body>Hello World</body></html>}
    end
  end

  context 'does not execute javascript' do
    it 'for non bots' do
      get '/'
      last_response.body.strip.should == html
    end

    it 'for non html responses'

    it 'for POST requests' do
      post '/', {}, as_bot
      last_response.body.strip.should == html
    end
  end

  def as_bot
    {'HTTP_USER_AGENT' => 'Googlebot'}
  end
end
