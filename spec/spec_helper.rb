require 'coveralls'
require 'simplecov'
SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_filter do |source_file|
    if source_file.filename.include?("plugins/redmine_persist_wfmt") && source_file.filename.end_with?(".rb")
      source_file.filename.include?("/spec/")
    else
      true
    end
  end
end

require File.expand_path('spec/spec_helper') if File.exist?(File.expand_path('spec/spec_helper.rb'))

require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, timeout: 120)
end

Dir[File.expand_path("#{File.dirname(__FILE__)}/support/**/*.rb")].each { |f| require f }
RSpec.configure do |config|
  config.include Features::Macros, type: :feature
  config.include Features::Helpers, type: :feature

  config.fixture_path = "#{::Rails.root}/test/fixtures"
  config.use_transactional_fixtures = false
  config.before(:suite) { DatabaseCleaner.strategy = :truncation }
  config.before(:each)  { DatabaseCleaner.start }
  config.after(:each) do
    DatabaseCleaner.clean
    page.driver.reset! if defined?(page)
  end
end
