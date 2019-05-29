module Pwfmt
  # This patch extends ApplicationController.
  # Save wiki format to context before action.
  # Clear context after action.
  module ApplicationControllerPatch
    extend ActiveSupport::Concern

    included do
      before_action :store_pwfmt_params
      after_action :clear_pwfmt_context
    end

    private

    # save format to context
    def store_pwfmt_params
      Pwfmt::Context.formats = params[:pwfmt][:formats] if params[:pwfmt]
    end

    # clear context
    def clear_pwfmt_context
      Pwfmt::Context.clear
    end
  end
end

require 'application_controller'
ApplicationController.__send__(:include, Pwfmt::ApplicationControllerPatch)
