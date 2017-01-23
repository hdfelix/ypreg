# require 'simplecov'
# SimpleCov.start 'rails'

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara-screenshot/rspec'
# require 'capybara/poltergeist'

# Set the default driver
Capybara.javascript_driver = :webkit # :poltergeist

# Capybara Screenshot config
Capybara.asset_host = 'http://localhost:3000'
# Capybara::Screenshot.autosave_on_failure = false
Capybara::Screenshot.webkit_options = { width: 1024, height: 1024 }
Capybara::Screenshot.prune_strategy = :keep_last_run

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
ActiveRecord::Migration.maintain_test_schema! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.include_chain_clauses_in_custom_matcher_descriptions = true
    c.syntax = :expect
  end

  # launchy

	config.include FeatureLoginMacros
	config.include ApplicationHelper
  config.include WaitForAjax
  config.include ControllerMacros, type: :controller
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = true

  config.infer_spec_type_from_file_location!
  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  #config.order = "random"
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
