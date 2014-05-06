module ApplicationControllerPatch
  extend ActiveSupport::Concern

  included do
    if respond_to?(:before_action)
      before_action :store_pwfmt_format
    else
      before_filter :store_pwfmt_format
    end
  end

  private

  def store_pwfmt_format
    if params[:pwfmt]
      PwfmtContext.format = params[:pwfmt][:format]
      PwfmtContext.field = params[:pwfmt][:field]
    end
  end
end

if require "application_controller"
  ApplicationController.send(:include, ApplicationControllerPatch)
end
