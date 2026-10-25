require 'simplecov'
require 'simplecov-lcov'
SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
SimpleCov.formatter = SimpleCov::Formatter::LcovFormatter
SimpleCov.start do
  skip(%r{/^/spec//}) # For RSpec

  skip(%r{/^/test//}) # For Minitest
end

require 'rspec/rails'
require 'shoulda/matchers'
