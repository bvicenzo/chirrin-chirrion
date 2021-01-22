# frozen_string_literal: true

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chirrin-chirrion/version'

Gem::Specification.new do |spec|
  spec.name          = 'chirrin-chirrion'
  spec.version       = ChirrinChirrion::VERSION
  spec.authors       = ['Bruno Vicenzo']
  spec.email         = ['greenmetal@gmail.com']

  spec.summary       = %q{Easy way to create and manage toggles}
  spec.description   = %q{Chirrin for the new code apears, Chirrion for the new code desapears (by Chapolim)}
  spec.homepage      = 'https://github.com/bvicenzo/chirrin-chirrion'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  end

  #Development dependencies
  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2.0'
  spec.add_development_dependency 'redis', '~> 3.2.1'
  
  #Runtime dependencies
  spec.add_runtime_dependency 'json', '>= 1'
end
