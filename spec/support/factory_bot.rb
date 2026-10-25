FactoryBot.use_parent_strategy = false # keep FactoryBot 4 behavior: associations are created, not built

RSpec.configure do |config|
  # Save time when using  FactoryBot Methods
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.start
    FactoryBot.lint
    DatabaseCleaner.clean
  end
end
