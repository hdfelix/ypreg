require 'simplecov'
require 'simplecov-lcov'
SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
SimpleCov.formatter = SimpleCov::Formatter::LcovFormatter
SimpleCov.start do
  add_filter(%r{/^\/spec\//}) # For RSpec

  add_filter(%r{/^\/test\//}) # For Minitest
end

require 'undercover'
require 'rspec/rails'
require 'shoulda/matchers'
