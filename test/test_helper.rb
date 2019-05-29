module Pwfmt
  # Root module of testing API for this plugin.
  module Testing
    # Remove when redmine uses newly selenium.
    module SilentDeprecated
      def deprecate(old, new = nil)
        # do nothing for shut out deprecated warning.
      end
    end
  end
end

Selenium::WebDriver::Logger.prepend(Pwfmt::Testing::SilentDeprecated)
