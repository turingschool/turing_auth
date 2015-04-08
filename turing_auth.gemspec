# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'turing_auth/version'

Gem::Specification.new do |spec|
  spec.name          = "turing_auth"
  spec.version       = TuringAuth::VERSION
  spec.authors       = ["worace"]
  spec.email         = ["horace.d.williams@gmail.com"]
  spec.summary       = %q{Shared authentication logic for turing apps.}
  spec.description   = %q{Authentication for Turing platform built on top of github orgs and github oauth.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "omniauth"
  spec.add_runtime_dependency "omniauth-github"
  spec.add_runtime_dependency "octokit"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
