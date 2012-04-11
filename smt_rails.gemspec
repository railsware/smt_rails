# -*- encoding: utf-8 -*-
require File.expand_path('../lib/smt_rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alexey Vasiliev", "Alexander Chaplinsky"]
  gem.email         = ["contacts@railsware.com"]
  gem.description   = %q{Shared mustache templates for rails 3}
  gem.summary       = %q{Shared mustache templates for rails 3}
  gem.homepage      = "https://github.com/railsware/smt_rails"
  
  gem.extra_rdoc_files  = [ "LICENSE", "README.md" ]
  gem.rdoc_options      = ["--charset=UTF-8"]

  #gem.add_development_dependency "jasmine",         ">= 1.0.0"
  
  gem.add_runtime_dependency "rails",           ">= 3.1.0"
  gem.add_runtime_dependency "tilt",            ">= 1.3.3"
  gem.add_runtime_dependency "sprockets",       ">= 2.0.3"
  gem.add_runtime_dependency "mustache",        ">= 0.99.4"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "smt_rails"
  gem.require_paths = ["lib"]
  gem.version       = SmtRails::VERSION
end
