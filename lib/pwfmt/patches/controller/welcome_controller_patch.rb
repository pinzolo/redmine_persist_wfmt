module Pwfmt
  module Patches
    module Controller
      # This patch extends WelcomesController.
      # This patch enables to load user selected format of welcom text.
      module WelcomeControllerPatch
        extend ActiveSupport::Concern

        included do
          before_render :load_wiki_format, only: :index
        end

        private

        # load wiki format of itself from database
        def load_wiki_format
          pwfmt = PwfmtFormat.where(field: 'settings_welcome_text').first
          Setting.welcome_text.wiki_format = pwfmt.format if Setting.welcome_text && pwfmt
        end
      end
    end
  end
end

require 'welcome_controller'
WelcomeController.__send__(:include, Pwfmt::Patches::Controller::WelcomeControllerPatch)
