require 'bundler/setup'

require 'pry'

APP_ROOT = File.expand_path('../../', __FILE__)
lib = "#{APP_ROOT}/lib"
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir      = "#{APP_ROOT}/spec/fixtures/cassette_library"
  c.hook_into                 :webmock
  c.ignore_localhost          = true
  c.default_cassette_options  = {
    :record => :new_episodes,
    :serialize_with => :json,
    :preserve_exact_body_bytes => true
  }
end

require 'rspec'

RSpec.configure do |config|
  config.mock_with :rspec

  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.extend VCR::RSpec::Macros
end
