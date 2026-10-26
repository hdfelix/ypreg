require 'simplecov'
require 'simplecov-lcov'
SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [SimpleCov::Formatter::LcovFormatter, SimpleCov::Formatter::SimpleFormatter]
)
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/db/'
  add_filter '/config/'
  track_files '{app,lib}/**/*.rb'
end

require 'rspec/rails'
require 'shoulda/matchers'
