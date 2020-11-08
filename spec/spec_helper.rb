require "rn/configuration"
require 'bundler'
Bundler.require

RSpec.configure do |config|
  config.formatter = :documentation

  config.before(:suite) do
    swap_values = RN::Configuration::BASE_PATH, RN::Configuration::TEST_BASE_PATH
    RN::Configuration::TEST_BASE_PATH, RN::Configuration::BASE_PATH = swap_values
    RSpec::Mocks.with_temporary_scope do
      allow(STDOUT).to receive(:puts)
    end
  end

  config.before(:each) do
    RN::Configuration::reset
  end
end
