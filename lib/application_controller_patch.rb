module Pwfmt::ApplicationControllerPatch
  extend ActiveSupport::Concern

  included do
    before_filter :store_pwfmt_params
  end

  private

  def store_pwfmt_params
    if params[:pwfmt]
      Pwfmt::Context.formats = params[:pwfmt][:formats]
      Pwfmt::Context.fields = params[:pwfmt][:fields]
    end
  end
end

if require "application_controller"
  ApplicationController.send(:include, Pwfmt::ApplicationControllerPatch)
end
