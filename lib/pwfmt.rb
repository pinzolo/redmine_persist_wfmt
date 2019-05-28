# Root module for this plugin
module Pwfmt ; end

require_relative 'pwfmt_context'
require_relative 'pwfmt_helper'
require_relative 'pwfmt_hooks'

require_relative 'patches/ext/string_patch'
require_relative 'patches/ext/wiki_formatting_patch'

require_relative 'patches/helper/application_helper_patch'
require_relative 'patches/helper/textile_helper_patch'
require_relative 'patches/helper/markdown_helper_patch'

require_relative 'patches/controller/application_controller_patch'
require_relative 'patches/controller/documents_controller_patch'
require_relative 'patches/controller/issues_controller_patch'
require_relative 'patches/controller/journals_controller_patch'
require_relative 'patches/controller/messages_controller_patch'
require_relative 'patches/controller/news_controller_patch'
require_relative 'patches/controller/previews_controller_patch'
require_relative 'patches/controller/projects_controller_patch'
require_relative 'patches/controller/settings_controller_patch'
require_relative 'patches/controller/welcome_controller_patch'
require_relative 'patches/controller/wiki_controller_patch'

require_relative 'patches/model/comment_patch'
require_relative 'patches/model/document_patch'
require_relative 'patches/model/issue_patch'
require_relative 'patches/model/journal_patch'
require_relative 'patches/model/message_patch'
require_relative 'patches/model/news_patch'
require_relative 'patches/model/project_patch'
require_relative 'patches/model/setting_patch'
require_relative 'patches/model/wiki_content_patch'
require_relative 'patches/model/wiki_content_version_patch'
