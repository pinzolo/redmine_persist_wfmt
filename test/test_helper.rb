require 'coveralls'
require 'simplecov'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_filter do |source_file|
    if source_file.filename.include?("plugins/redmine_persist_wfmt") && source_file.filename.end_with?(".rb")
      source_file.filename.include?("/test/")
    else
      true
    end
  end
end

module Pwfmt::Testing; end
