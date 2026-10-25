require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module YpwReg
  class Application < Rails::Application
    config.load_defaults 8.1

    config.assets.paths << Rails.root.join('app/assets/stylesheets/kingadmin-v1.2')
    config.assets.paths << Rails.root.join('app/assets/javascripts/kingadmin-v1.2')
    config.assets.paths << Rails.root.join('app/assets/fonts')

    config.time_zone = 'Pacific Time (US & Canada)'
    config.i18n.default_locale = :en

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
  end
end
