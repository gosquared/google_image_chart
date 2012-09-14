#!/usr/bin/env gem build

Gem::Specification.new do |gem|
  gem.name          = 'google_image_chart'
  gem.version       = '0.1.0'
  gem.authors       = ['Gerhard Lazu']
  gem.email         = ['gerhard@lazu.co.uk']
  gem.description   = %q{Creates PNGs from chart data}
  gem.summary       = %q{Simple wrapper to the Google Image Chart API - yes, the deprecated one}
  gem.homepage      = 'https://github.com/gosquared/google_image_chart'

  gem.files         = Dir['lib/**/*', 'examples/**/*', 'Gemfile', 'google_image_chart.gemspec', 'README.md', 'LICENSE']
  gem.test_files    = Dir['spec/**/*']
  gem.executables   = Dir['bin/*']
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'hashie', '~> 1.2.0'
end
