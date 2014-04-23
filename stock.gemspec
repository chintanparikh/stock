# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stock/version'

Gem::Specification.new do |spec|
  spec.name          = "stock"
  spec.version       = Stock::VERSION
  spec.authors       = ["Chintan Parikh"]
  spec.email         = ["chintanparikh@gatech.edu"]
  spec.summary       = "Get information about stocks (prices, earnings, etc"
  spec.description   = "TBD"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"
  spec.add_dependency "rest_client"

  spec.add_development_dependency "debugger"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.6"
end
