source 'https://rubygems.org'

ruby '3.4.8'

gem 'rails', '~> 8.1.4'

gem 'bootsnap', require: false
gem 'pg', '~> 1.5'
gem 'puma', '>= 6.0'

# Assets (Sprockets pipeline retained from the Rails 5.2 app)
gem 'autoprefixer-rails'
gem 'bootstrap-datepicker-rails'
gem 'bootstrap-sass', '~> 3.4'
gem 'font-awesome-sass', '~> 4.7'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'sassc-embedded'
gem 'sass-rails'
gem 'sprockets-rails'
gem 'terser'

# Views / forms / presentation
gem 'draper'
gem 'haml-rails'
gem 'jbuilder'
gem 'simple_form'

# Auth / authorization / search / uploads
gem 'carrierwave', '~> 3.0'
gem 'devise'
gem 'mini_magick'
gem 'pg_search'
gem 'pundit'

# Monitoring
gem 'rollbar'

group :development, :test do
  gem 'awesome_print'
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'rails-controller-testing'
  gem 'rspec-collection_matchers'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'shoulda-matchers'
end

group :development do
  gem 'bullet'
  gem 'letter_opener'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'database_cleaner-active_record'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'simplecov'
  gem 'simplecov-lcov'
  gem 'timecop'
end
