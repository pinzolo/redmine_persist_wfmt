# This patch extends PreviewsController.
# This patch enables to preview by selected format.
module Pwfmt::PreviewsControllerPatch
  extend ActiveSupport::Concern

  included do
    before_render :set_wiki_format_for_preview
  end

  private

  # set wiki format of itself for preview from request
  def set_wiki_format_for_preview
    @text.wiki_format = params[:pwfmt_format] if @text && params[:pwfmt_format]
  end
end

require 'previews_controller'
PreviewsController.__send__(:include, Pwfmt::PreviewsControllerPatch)
