# require 'coveralls'
# require 'simplecov'

module Pwfmt::Testing; end

# SimpleCov.formatter = Coveralls::SimpleCov::Formatter
# SimpleCov.start do
#   add_filter do |source_file|
#     if source_file.filename.include?("plugins/redmine_persist_wfmt") && source_file.filename.end_with?(".rb")
#       source_file.filename.include?("/test/")
#     else
#       true
#     end
#   end
# end

# Remove when redmine uses newly selenium.
module SilentDeprecated
  def deprecate(old, new = nil)
    # do nothing for shut out deprecated warning.
  end
end
Selenium::WebDriver::Logger.prepend(SilentDeprecated)
