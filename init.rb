require_relative 'lib/view_hook'

Redmine::Plugin.register :redmine_persist_wfmt do
  name 'Redmine persist wiki format plugin'
  author 'pinzolo'
  description 'This is a plugin for Redmine that persists wiki format'
  version '0.0.1'
  url 'https://github.com/pinzolo/redimen_persist_wfmt'
  author_url 'https://github.com/pinzolo'
end

require_relative 'lib/string_patch'
require_relative 'lib/pwfmt_context'
require_relative 'lib/pwfmt_helper'
require_relative 'lib/textile_helper_patch'
require_relative 'lib/markdown_helper_patch'
require_relative 'lib/application_controller_patch'
require_relative 'lib/wiki_formatting_patch'

require_relative 'lib/project_patch'
require_relative 'lib/projects_controller_patch'
require_relative 'lib/issue_patch'
require_relative 'lib/issues_controller_patch'
require_relative 'lib/journal_patch'
require_relative 'lib/journals_controller_patch'
require_relative 'lib/journals_helper_patch'
require_relative 'lib/document_patch'
require_relative 'lib/documents_controller_patch'
require_relative 'lib/news_patch'
require_relative 'lib/news_controller_patch'

require_relative 'lib/application_helper_patch'
