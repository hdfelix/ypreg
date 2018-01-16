RSpec.configure do |config|
	# Save time when using  FactoryBot Methods
	config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.start
    FactoryBot.lint
    DatabaseCleaner.clean
  end
end
