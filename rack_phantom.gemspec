# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack_phantom/version'

Gem::Specification.new do |spec|
  spec.name          = 'rack_phantom'
  spec.version       = RackPhantom::VERSION
  spec.authors       = ['Selva']
  spec.email         = ['k.n.selvakumar@gmail.com']
  spec.description   = 'Rack middlware to render single page apps (or any html page with javascript) with phantomjs and return plain html for bots.'
  spec.summary       = ''
  spec.homepage      = 'https://github.com/selvakn/rack_phantom'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.add_dependency 'rack', '~> 1.5.2'
  spec.add_dependency 'phantomjs.rb', '~> 1.0.1'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rspec'
end
