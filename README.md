# RackPhantom

Rack middleware to render single page apps (or any html page with javascript) with phantomjs and return plain html for bots.

## Travis

[![Build Status](https://travis-ci.org/selvakn/rack_phantom.png)](https://travis-ci.org/selvakn/rack_phantom)

## Installation

Add this line to your application's Gemfile:

    gem 'rack_phantom'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack_phantom

## Usage

### Rack App (like sinatra)
    use RackPhantom::Middleware
    
### Rails App
    Add to Gemfile. And rest is magic.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
