#!/usr/bin/env gem build
# -*- encoding: utf-8 -*-
#lib = File.expand_path('../lib', __FILE__)
#$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = 'google_chart'
  gem.version       = '0.1.0'
  gem.authors       = ['Gerhard Lazu']
  gem.email         = ['gerhard@lazu.co.uk']
  gem.description   = %q{Creates nice PNGs from chart data}
  gem.summary       = %q{Simple wrapper to the Google Chart API}
  gem.homepage      = 'https://github.com/gosquared/google_chart'

  gem.files         = Dir['lib/**/*', 'examples/**/*', 'Gemfile', 'google_chart.gemspec', 'README.md', 'LICENSE']
  gem.test_files    = Dir['spec/**/*']
  gem.executables   = Dir['bin/*']
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'hashie', '~> 1.2.0'
end
