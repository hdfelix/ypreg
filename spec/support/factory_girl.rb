RSpec.configure do |config|
	# Save time when using  FactoryGirl Methods
	config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.start
    FactoryGirl.lint
    DatabaseCleaner.clean
  end

end

