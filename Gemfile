source 'https://rubygems.org'
ruby ENV["RUBY_VERSION"]

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# gem 'rails', '4.1.4'
gem 'rails', '4.1.8'


# Entity diagrams
group :development do
  gem 'railroady'
end

group :development do
  # Get warnings about inefficient queries
  gem 'bullet'
end

# Asset pipeline - is this gem needed? (http://guides.rubyonrails.org/asset_pipeline.html)
# gem 'sprockets-rails', :require => 'sprockets/railtie'

gem 'pg'
gem 'foreigner'
gem 'immigrant'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Font Awesome
gem 'font-awesome-rails'

# CSS Framework
gem 'bootstrap-sass', '~> 3.1.1'
# gem 'anjlab-bootstrap-rails',
#   require: 'bootstrap-rails',
#   github: 'anjlab/bootstrap-rails',
#   branch:'3.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# gem 'jquery-ui-rails'
# gem 'jquery-rails-cdn'
gem 'jquery-ui-rails', '~> 4.2.1'
# gem 'jquery-turbolinks'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# User authentication
gem 'devise'
gem 'pundit'
gem 'figaro'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc' # require: false
  gem 'yard'
end

# serve static_assets
gem 'rails_12factor', group: :production

gem 'simple_form'

group :development, :test do
  # Add Pry for debugging
  gem 'pry'
  # gem 'pry-rails'
  gem 'pry-rescue'
  gem 'pry-byebug'
  gem 'binding_of_caller'
  gem 'shoulda-matchers'
  gem 'rspec-rails'
  gem 'rspec-collection_matchers'
  gem 'factory_girl_rails'
  gem 'faker'
  # gem 'ffaker'
  gem 'simplecov', require: false
  gem 'simplecov-csv', require: false
  gem 'coverband'
  gem 'rspec_junit_formatter'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false

  # gem 'haml-lint', require: false
  gem 'letter_opener', group: :development

  # Annotate DB schema in models
  # gem 'annotate'

end

group :development do
  gem 'awesome_print'
  gem 'better_errors'
  gem 'quiet_assets'
  # gem 'rb-fsevent'
  gem 'guard-livereload'
  # Spring speeds up development by keeping your application running in the 
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'capybara', '~> 2.3.0'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'capybara-webkit'
  gem 'guard-rspec'
end

# Geographic data
# gem 'carmen-rails', '~> 1.0.0'
