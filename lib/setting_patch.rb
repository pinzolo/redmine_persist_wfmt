module Pwfmt::SettingPatch
  extend ActiveSupport::Concern

  included do
    after_find :load_wiki_format!
    after_save :persist_wiki_format
  end

  def load_wiki_format!
    if self.name == 'welcome_text'
      pwfmt = PwfmtFormat.where(target_id: self.id, field: 'settings_welcome_text').first
      value.pwfmt = pwfmt if value && pwfmt
    end
  end

  def persist_wiki_format
    if self.name == 'welcome_text' && Pwfmt::Context.formats && Pwfmt::Context.formats.key?('settings_welcome_text')
      pwfmt = PwfmtFormat.where(target_id: self.id, field: 'settings_welcome_text').first
      if pwfmt
        pwfmt.update_attributes(format: Pwfmt::Context.formats['settings_welcome_text'])
      else
        PwfmtFormat.create(target_id: self.id,
                           field: 'settings_welcome_text',
                           format: Pwfmt::Context.formats['settings_welcome_text'])
      end
    end
  end
end

require 'setting'
Setting.send(:include, Pwfmt::SettingPatch)

