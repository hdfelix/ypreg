YpwReg::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Note: In rails 4.0/4.1 The default rails test environment
  # ( config/environments/test.rb ) is not threadsafe - 
  # see https://github.com/rails/rails/issues/15089. If you experience random
  # errors about missing constants, adding config.allow_concurrency = false to 
  # config/environements/test.rb should solve the issue.
   config.allow_concurrency = false

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static asset server for tests with Cache-Control for performance.
  config.public_file_server.enabled = true
  config.public_file_server.headers = { 'Cache-Control' => 'public, max-age=3600' }

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr
  config.action_mailer.default_url_options = { host: 'localhost:3000' }

  # Currently, Active Record suppresses errors raised within
  # `after_rollback`/`after_commit` callbacks and only print them to the logs.
  # In the next version, these errors will no longer be suppressed. Instead,
  # the errors will propagate normally just like in other Active Record callbacks.
  # You can opt into the new behavior and remove this warning by setting:
  config.active_record.raise_in_transactional_callbacks = true

  # Simplecov (https://github.com/colszowka/simplecov#want-to-use-spring-with-simplecov)

  config.public_file_server.enabled = true
  # config.eager_load = false
end
