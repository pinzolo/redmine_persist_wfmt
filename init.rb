Redmine::Plugin.register :redmine_persist_wfmt do
  name 'Redmine persist wiki format plugin'
  author 'pinzolo'
  description 'This plugin enables to select and save format of wiki.'
  version '2.0.1'
  url 'https://github.com/pinzolo/redmine_persist_wfmt'
  author_url 'https://github.com/pinzolo'
end

require_relative 'lib/pwfmt'
