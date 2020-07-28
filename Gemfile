source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com#{repo}.git" }

ruby '2.6.5'

gem 'rails', '5.2.0'

gem 'actionpack'
gem 'activemodel'
gem 'activerecord'
gem 'railties'
gem 'autoprefixer-rails'
gem 'awesome_print'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap-sass'
gem 'bootstrap-datepicker-rails'

# Avatar uploader
gem 'carrierwave', '~>1.2.2'
gem 'coffee-rails', '~> 4.2'

# Authentication
gem 'devise', git: 'https://github.com/plataformatec/devise.git', branch: 'master'

# Decorator pattern
gem 'draper'

gem 'faker'
# manage environment variables
gem 'figaro', '~>1.1.1'
gem 'font-awesome-sass'
# gem 'foreigner'
gem 'haml-rails'
# gem 'immigrant'

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jbuilder', '~> 2.5'

# Use ActiveStorage variant
gem 'mini_magick', '~> 4.8'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby
# PDF generation
# gem 'prawn'

# searching
gem 'pg_search', '~>2.1.2'

# Authorization
gem 'pundit'
gem 'pry-byebug'
gem 'pry-rails'
gem 'pry-rescue'
# Use Puma as teh app server
gem 'puma', '~> 3.12'

# Monitoring
gem 'rollbar'

# gem 'redis', '~>4.0' # for ActionCable in production
gem 'sass-rails', '>= 3.2'
gem 'simple_form'
gem 'skylight'
gem 'sprockets', '~> 3.7.2'
gem 'turbolinks', '~>5'
gem 'uglifier', '>= 1.3.0'
gem 'undercover'

group :production do
  gem 'pg', '~>0.21'
  gem 'rails_12factor'
end

group :development do
  gem 'better_errors'
  gem 'bullet'
  # gem 'guard-livereload'
  gem 'listen', '>=3.0.5', '< 3.2'
  # gem 'quiet_assets'
  gem 'railroady'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
  # gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :development, :test do
  gem 'binding_of_caller'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'coverband'
  gem 'factory_bot_rails'
  gem 'letter_opener', group: :development
  gem 'rails_best_practices'
  gem 'rails-controller-testing'
  gem 'rspec-collection_matchers'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'
  gem 'rubocop', '~> 0.52.1', require: false
  gem 'rubocop-rspec', require: false
  gem 'shoulda-matchers', '~> 3.1.2', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'master'
#   gem 'simplecov', require: false
#   gem 'simplecov-csv', require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'capybara-chromedriver-logger'
  gem 'capybara-screenshot'
  # Easy installation and use of chromedriver to run system tests with Chrome
  # gem 'chromedriver-helper'
  gem 'webdrivers', '~> 4.0'
  gem 'database_cleaner'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'simplecov'
  gem 'simplecov-lcov'
  gem 'timecop'
end

group :doc do
  gem 'sdoc' # require: false
  gem 'yard'
end
