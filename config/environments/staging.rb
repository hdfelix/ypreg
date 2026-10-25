require_relative 'production'

Rails.application.configure do
  config.action_mailer.default_url_options = { host: 'ypreg-staging.herokuapp.com' }
end
