if require "application_controller"
  class ApplicationController < ActionController::Base
    if respond_to?(:before_action)
      before_action :store_pwfmt_format
    else
      before_filter :store_pwfmt_format
    end

    private

    def store_pwfmt_format
      PwfmtContext.format = params[:pwfmt][:format] if params[:pwfmt]
    end
  end
end
