# -*- encoding: utf-8 -*-
require File.expand_path('../lib/alloy/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Junya Ogura"]
  gem.email         = ["junyaogura@gmail.com"]
  gem.description   = %q{Toolbelt for Titanium Mobile development.}
  gem.summary       = %q{Toolbelt for Titanium Mobile development.}
  gem.homepage      = "https://github.com/qnyp/alloy"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "alloy"
  gem.require_paths = ["lib"]
  gem.version       = Alloy::VERSION

  gem.add_dependency('colored', '~> 1.2')
  gem.add_dependency('json', '~> 1.6.6')
  gem.add_dependency('nokogiri', '~> 1.5.2')
  gem.add_dependency('thor', '~> 0.14.6')

  gem.add_development_dependency('rspec', '~> 2.9.0')
end
