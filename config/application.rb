require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module YpwReg
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    console do
      if Rails.env.production?
        config.console = IRB
      else
        # This block is called only when running console, so we can safely require pry here.
        require 'pry'
        config.console = Pry
      end
    end

    # http://stackoverflow.com/a/7412056
    if (Rails.env.development? || Rails.env.test?)
      ActionDispatch::Callbacks.after do
        # Reload the factories
        unless FactoryGirl.factories.blank? # first init will load factories, this should only run on subsequent reloads
          FactoryGirl.factories.clear
          FactoryGirl.find_definitions
        end
      end
    end
  end
end
