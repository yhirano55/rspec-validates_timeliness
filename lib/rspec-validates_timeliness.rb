require 'rspec/core'
require 'rspec-validates_timeliness/matchers'
require 'rspec-validates_timeliness/version'

RSpec.configure do |config|
  config.include RSpec::ValidatesTimeliness::Matchers
end
