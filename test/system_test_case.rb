require 'application_system_test_case'
require_relative './test_helper'
require_relative './data_helper'
require_relative './macro'
require_relative './value'

# Base class for this plugin's system test
# Use headless chrome as selenium driver
class Pwfmt::SystemTestCase < ApplicationSystemTestCase
  include Pwfmt::Testing::DataHelper
  include Pwfmt::Testing::Macro
  include Pwfmt::Testing::Value

  driven_by :selenium, using: :headless_chrome, screen_size: [1440, 900], options: {
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
      'chromeOptions' => {
        'prefs' => {
          'download.default_directory' => DOWNLOADS_PATH,
          'download.prompt_for_download' => false,
          'plugins.plugins_disabled' => ["Chrome PDF Viewer"]
        }
      }
    )
  }
end
