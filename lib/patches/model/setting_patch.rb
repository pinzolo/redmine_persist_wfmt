module Pwfmt::SettingPatch
  extend ActiveSupport::Concern

  included do
    after_save :persist_wiki_format
  end

  def persist_wiki_format
    PwfmtFormat.persist(self, 'settings_welcome_text')
  end
end

Rails.configuration.to_prepare do
  require 'setting'
  Setting.__send__(:include, Pwfmt::SettingPatch)
end
