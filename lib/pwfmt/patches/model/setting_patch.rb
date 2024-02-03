module Pwfmt
  module Patches
    module Model
      # This patch extends project that allows load and save wiki format of welcom text
      module SettingPatch
        extend ActiveSupport::Concern

        included do
          after_save :persist_wiki_format
        end

        # save wiki format of welcom text to database.
        def persist_wiki_format
          PwfmtFormat.persist(self, 'settings_welcome_text')
        end
      end
    end
  end
end

Rails.configuration.to_prepare do
  require 'setting'
  Setting.__send__(:include, Pwfmt::Patches::Model::SettingPatch)
end
