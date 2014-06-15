module Pwfmt::WelcomeControllerPatch
  extend ActiveSupport::Concern

  included do
    before_render :load_wiki_format, only: [:index]
  end

  private

  def load_wiki_format
    pwfmt = PwfmtFormat.where(field: 'settings_welcome_text').first
    Setting.welcome_text.wiki_format = pwfmt.format if Setting.welcome_text && pwfmt
  end
end

require "welcome_controller"
WelcomeController.send(:include, Pwfmt::WelcomeControllerPatch)


