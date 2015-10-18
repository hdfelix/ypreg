require 'database_cleaner'

def select_by_value(id, value)
	  option_xpath = "//*[@id='#{id}']/option[@value='#{value}']"
		option = find(:xpath, option_xpath).text
		select(option, :from => id)
end

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:deletion)
    DatabaseCleaner.clean
  end

  config.before(:each) do |example|
    DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

