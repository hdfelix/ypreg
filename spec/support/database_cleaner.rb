require 'database_cleaner'

def select_by_value(id, value)
	  option_xpath = "//*[@id='#{id}']/option[@value='#{value}']"
		option = find(:xpath, option_xpath).text
		select(option, :from => id)
end

RSpec.configure do |config|

	config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
		DatabaseCleaner.clean_with(:truncation)
	end

	config.before(:each) do
		DatabaseCleaner.start
	end

	config.before(:each, :js => true) do
		DatabaseCleaner.strategy = :truncation
	end

	config.after(:each) do
		DatabaseCleaner.clean
	end
end
