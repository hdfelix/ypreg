source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.1'

gem 'rails', '5.1.1'

# gem 'actionpack'
gem 'activemodel'
# gem 'activerecord'
# gem 'railties'
gem 'autoprefixer-rails'
gem 'awesome_print'
gem 'bootstrap-sass'

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

# gem 'jquery-rails'
# gem 'jquery-ui-rails'
gem 'jbuilder', '~> 2.5'

# Image processing
gem 'mini_magick'
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
gem 'puma', '~> 3.7'

# gem 'redis', '~>3.0' # for ActionCable in production
gem 'sass-rails', '>= 3.2'
gem 'simple_form'
gem 'skylight'
gem 'turbolinks', '~>5'
gem 'uglifier', '>= 1.3.0'

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
  gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

  # Access an IRB console on exception pages by using <%= console %> anywhere in the code.
  gem 'web-console' , '>= 3.3.0'
end

group :development, :test do
  gem 'binding_of_caller'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'coverband'
  gem 'factory_bot_rails'
  gem 'letter_opener', group: :development
  gem 'rspec-collection_matchers'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'
  gem 'rubocop', '~> 0.52.1', require: false
  gem 'rubocop-rspec', require: false
  gem 'shoulda-matchers', '~> 3.1.1'
#   gem 'simplecov', require: false
#   gem 'simplecov-csv', require: false
end

group :test do
  gem 'capybara-screenshot'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'timecop'
end

group :doc do
  gem 'sdoc' # require: false
  gem 'yard'
end

