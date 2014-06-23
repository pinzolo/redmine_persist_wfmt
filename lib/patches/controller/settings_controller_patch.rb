module Pwfmt::SettingsControllerPatch
  extend ActiveSupport::Concern

  included do
    before_render :load_wiki_format, only: [:edit, :index]
    before_render :reserve_format, only: [:edit, :index]
  end

  private

  def load_wiki_format
    pwfmt = PwfmtFormat.where(field: 'settings_welcome_text').first
    Setting.welcome_text.wiki_format = pwfmt.format if Setting.welcome_text && pwfmt
  end

  def reserve_format
    Pwfmt::Context.reserve_format('settings_welcome_text', Setting.welcome_text)
  end
end

require 'settings_controller'
SettingsController.__send__(:include, Pwfmt::SettingsControllerPatch)

