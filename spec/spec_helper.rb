require 'simplecov'
SimpleCov.start do
  add_filter '.bundle/'
  add_filter 'spec/'
end

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rspec'

require 'alloy'

RSpec.configure do |config|
  config.mock_with :rspec
end
