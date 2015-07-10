source 'https://rubygems.org'

gem 'rails', '4.1.8'

gem 'pg'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'sass-rails', '>= 3.2'
gem 'autoprefixer-rails'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'jquery-ui-rails', '~> 4.2.1'
gem 'jbuilder', '~> 1.2'

gem 'foreigner'
gem 'immigrant'
gem 'skylight'

# Authentication
gem 'devise'

# Authorization
gem 'pundit'

# manage environment variables
gem 'figaro'

# PDF generation
gem 'prawn'

gem 'simple_form'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'awesome_print'
  gem 'better_errors'
  gem 'quiet_assets'
  gem 'guard-livereload'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'railroady'
  gem 'bullet'
end

group :development, :test do
  gem 'pry'
  gem 'pry-rescue'
  gem 'pry-byebug'
  gem 'binding_of_caller'
  gem 'shoulda-matchers', require: false
  gem 'rspec-rails'
  gem 'rspec-collection_matchers'
  # gem 'rspec-mocks'
  gem 'rspec_junit_formatter'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'simplecov', require: false
  gem 'simplecov-csv', require: false
  gem 'coverband'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'letter_opener', group: :development
end

group :test do
  gem 'capybara', '~> 2.3.0'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'capybara-webkit'
  gem 'guard-rspec'
end

group :doc do
  gem 'sdoc' # require: false
  gem 'yard'
end
