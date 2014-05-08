module Pwfmt::ApplicationControllerPatch
  extend ActiveSupport::Concern

  included do
    before_filter :store_pwfmt_params
    after_filter :clear_pwfmt_context
  end

  private

  def store_pwfmt_params
    if params[:pwfmt]
      Pwfmt::Context.formats = params[:pwfmt][:formats]
      Pwfmt::Context.fields = params[:pwfmt][:fields]
    end
  end

  def clear_pwfmt_context
    Pwfmt::Context.clear
  end
end

require "application_controller"
ApplicationController.send(:include, Pwfmt::ApplicationControllerPatch)
