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
    PwfmtContext.format = params[:pwfmt][:format] if params[:pwfmt]
  end
end

if require "application_controller"
  ApplicationController.send(:include, ApplicationControllerPatch)
end
