module Pwfmt::ApplicationControllerPatch
  extend ActiveSupport::Concern

  included do
    before_action :store_pwfmt_params
    after_action :clear_pwfmt_context
  end

  private

  def store_pwfmt_params
    Pwfmt::Context.formats = params[:pwfmt][:formats] if params[:pwfmt]
  end

  def clear_pwfmt_context
    Pwfmt::Context.clear
  end
end

require 'application_controller'
ApplicationController.__send__(:include, Pwfmt::ApplicationControllerPatch)
