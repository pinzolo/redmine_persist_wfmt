# This patch extends SettingsController.
# This patch enables to load and save user selected format of welcom text.
module Pwfmt::SettingsControllerPatch
  extend ActiveSupport::Concern

  included do
    before_render :load_wiki_format, only: [:edit, :index]
    before_render :reserve_format, only: [:edit, :index]
  end

  private

  # load wiki format of itself from database
  def load_wiki_format
    pwfmt = PwfmtFormat.where(field: 'settings_welcome_text').first
    Setting.welcome_text.wiki_format = pwfmt.format if Setting.welcome_text && pwfmt
  end

  # store wiki format of itself to database
  def reserve_format
    Pwfmt::Context.reserve_format('settings_welcome_text', Setting.welcome_text)
  end
end

require 'settings_controller'
SettingsController.__send__(:include, Pwfmt::SettingsControllerPatch)

