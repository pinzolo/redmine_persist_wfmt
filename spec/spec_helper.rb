require File.expand_path('spec/spec_helper') if File.exists?(File.expand_path('spec/spec_helper.rb'))

require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

Dir[File.expand_path("#{File.dirname(__FILE__)}/support/**/*.rb")].each { |f| require f }
RSpec.configure do |config|
  config.include Features::Macros, type: :feature
  config.include Features::Helpers, type: :feature

  config.fixture_path = "#{::Rails.root}/test/fixtures"
  config.use_transactional_fixtures = false
  config.before(:suite) { DatabaseCleaner.strategy = :truncation }
  config.before(:each)  { DatabaseCleaner.start }
  config.after(:each)   { DatabaseCleaner.clean }
end
