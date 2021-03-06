require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module YpwReg
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.assets.initialize_on_precompile = false

    config.autoload_paths += Dir["#{Rails.root.to_s}/app/models/*"].find_all { |f| File.stat(f).directory? }

    # for jquery-rails-cdn
    # config.assets.precompile += ['jquery.js']

    config.assets.paths << Rails.root.join('app', 'assets', 'stylesheets', 'kingadmin-v1.2')
    config.assets.paths << Rails.root.join('app', 'assets', 'javascripts', 'kingadmin-v1.2')
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    config.assets.paths << Rails.root.join('app', 'assets', 'ico')
    config.assets.precompile += %w( .svg, .eot, .woff, .ttf )

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run 'rake -D time' for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Pacific Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en
    I18n.enforce_available_locales = true

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
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
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
  end
end
