# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'envm/version'

Gem::Specification.new do |spec|
  spec.name          = "envm"
  spec.version       = Envm::VERSION
  spec.authors       = ["Chris Ledet"]
  spec.email         = ["chris.ledet@teespring.com"]

  spec.summary       = "Manage environment variables within your Ruby project"
  spec.description   = "Manage environment variables within your Ruby project"
  spec.homepage      = "https://github.com/teespring/envm"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["envmlint"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3.0"
end
