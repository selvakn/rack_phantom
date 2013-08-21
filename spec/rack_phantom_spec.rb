require 'spec_helper'

describe RackPhantom do

  let(:html) { %q{<html><head><script>document.write("Hello World");</script></head><body></body></html>} }
  let(:real_app) { ->(env) { [200, {}, html] } }
  let(:app) { RackPhantom::App.new(real_app) }

  context 'executes javascript' do
    it 'for bots' do
      get '/'
      last_response.should be_ok
      last_response.body.strip.should == evaluated_html
    end

    it 'escapes the single quotes'

    def evaluated_html
      %q{<html><head><script>document.write("Hello World");</script></head><body>Hello World</body></html>}
    end
  end

  context 'does not execute javascript' do
    it 'for non bots'
    it 'for non html responses'
    it 'for POST requests'
  end
end
