module Pwfmt::ApplicationControllerPatch
  extend ActiveSupport::Concern

  included do
    before_filter :store_pwfmt_format
  end

  private

  def store_pwfmt_format
    if params[:pwfmt]
      Pwfmt::Context.format = params[:pwfmt][:format]
      Pwfmt::Context.field = params[:pwfmt][:field]
    end
  end
end

if require "application_controller"
  ApplicationController.send(:include, Pwfmt::ApplicationControllerPatch)
end
