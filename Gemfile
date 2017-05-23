source 'https://rubygems.org'
ruby '2.4.1'

#
gem 'rails', '~> 5.1.1'
# Use postgres as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'binding_of_caller'
  gem 'shoulda-matchers', '~> 3.1.1'
  gem 'rspec-rails'
  gem 'rspec-collection_matchers'
  gem 'rspec_junit_formatter'
  gem 'factory_girl_rails'
  gem 'coverband'
  gem 'rubocop', '~> 0.45.0', require: false
  gem 'rubocop-rspec', require: false
  gem 'letter_opener', group: :development
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# CSS
gem 'bootstrap-sass'
gem 'font-awesome-sass'

# Jquery
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Etc
#gem 'autoprefixer-rails'
#gem 'activemodel-serializers-xml'
#gem 'foreigner'
#gem 'immigrant'
#gem 'awesome_print'

# Authentication
gem 'devise'

# Authorization
gem 'pundit'

# Forms
gem 'simple_form'

# Decorator pattern
gem 'draper'

# HTML template
gem 'haml-rails'

# TODO: different seeds for dev and prod
gem 'faker'
group :test do
  gem 'capybara-webkit'
  gem 'capybara-screenshot'
  # gem 'poltergeist'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'guard-rspec'
  gem 'timecop'
end

group :doc do
  gem 'sdoc' # require: false
  gem 'yard'
end
