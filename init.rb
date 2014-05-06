# coding: utf-8
Redmine::Plugin.register :redmine_persist_wfmt do
  name 'Redmine persist wiki format plugin'
  author 'pinzolo'
  description 'This is a plugin for Redmine that persists wiki format'
  version '0.0.1'
  url 'https://github.com/pinzolo/redimen_persist_wfmt'
  author_url 'https://github.com/pinzolo'
end

require_relative 'lib/pwfmt_context'
require_relative 'lib/textile_helper_patch'
require_relative 'lib/markdown_helper_patch'
require_relative 'lib/application_controller_patch'
