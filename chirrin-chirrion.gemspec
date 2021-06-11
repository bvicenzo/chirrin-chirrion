# frozen_string_literal: true

require_relative 'lib/chirrin-chirrion/version'

Gem::Specification.new do |spec|
  spec.name          = 'chirrin-chirrion'
  spec.version       = ChirrinChirrion::VERSION
  spec.authors       = ['Bruno Vicenzo']
  spec.email         = ['greenmetal@gmail.com']

  spec.summary       = 'Easy way to create and manage toggles'
  spec.description   = 'Chirrin for the new code apears, Chirrion for the new code desapears (by Chapolim)'
  spec.homepage      = 'https://github.com/bvicenzo/chirrin-chirrion'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6.0')
  spec.require_paths = ['lib']

  spec.metadata['allowed_push_host'] = 'https://rubygems.org' if spec.respond_to?(:metadata)

  # Development dependencies
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'redis', '~> 4.3.0'
  spec.add_development_dependency 'rspec', '~> 3.10.0'

  # Runtime dependencies
  spec.add_runtime_dependency 'json', '>= 1'
end
