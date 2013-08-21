require 'spec_helper'

describe RackPhantom do

  let(:html) { %q{<html><head><script>document.write("Hello' World");</script></head><body></body></html>} }
  let(:real_app) { ->(env) { [200, {'Content-Type' => 'text/html'}, [html]] } }
  let(:app) { RackPhantom::Middleware.new(real_app) }


  context 'for bots' do
    it 'should execute javascript' do
      get '/', {}, as_bot
      last_response.should be_ok
      last_response.body.should == evaluated_html
    end

    it 'should update the content length header' do
      get '/', {}, as_bot
      last_response.headers['Content-Length'].should == evaluated_html.length.to_s
    end

    def evaluated_html
      %q{<html><head><script>document.write("Hello' World");</script></head><body>Hello' World</body></html>}
    end
  end


  context 'for non bots' do
    it 'should not render' do
      get '/'
      last_response.body.should == html
    end
  end

  context 'for POST requests' do
    it 'should not render' do
      post '/', {}, as_bot
      last_response.body.should == html
    end
  end

  context 'for non html responses' do
    let(:json) { '{}' }
    let(:real_app) { ->(env) { [200, {'Content-Type' => 'application/json'}, [json]] } }

    it 'should not render' do
      get '/'
      last_response.body.should == json
    end
  end

  def as_bot
    {'HTTP_USER_AGENT' => 'Googlebot'}
  end
end
