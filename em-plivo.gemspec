# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'em-plivo/version'

Gem::Specification.new do |spec|
  spec.name          = "em-plivo"
  spec.version       = EventMachine::Plivo::VERSION
  spec.authors       = ["Dmitry Panin"]
  spec.email         = ["dmitry.panin@yahoo.com"]
  spec.summary       = %q{An EventMachine port of PlivoRuby.}
  spec.homepage      = "https://github.com/bjorn-tf/em-plivo"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "plivo", "~> 0.3"
  spec.add_dependency "multi_json", '~> 1.0'
  spec.add_dependency "eventmachine", "~> 1.0"
  spec.add_dependency "em-http-request", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
