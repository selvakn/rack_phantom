require 'spec_helper'

describe RackPhantom do

  let(:real_app) { ->(env) {[200, {}, html]} }

  let(:app) { RackPhantom::App.new(real_app) }

  it 'says hello' do
    get '/'
    last_response.should be_ok
    last_response.body.strip.should == evaluated_html
  end

  def html
    '<html><head><script>document.write("Hello World");</script></head><body></body></html>'
  end

  def evaluated_html
    '<html><head><script>document.write("Hello World");</script></head><body>Hello World</body></html>'
  end
end
