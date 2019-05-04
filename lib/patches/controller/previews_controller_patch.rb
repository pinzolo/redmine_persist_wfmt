module Pwfmt::PreviewsControllerPatch
  extend ActiveSupport::Concern

  included do
    before_render :set_wiki_format_for_preview
  end

  private

  def set_wiki_format_for_preview
    @text.wiki_format = params[:pwfmt_format] if @text && params[:pwfmt_format]
  end
end

require 'previews_controller'
PreviewsController.__send__(:include, Pwfmt::PreviewsControllerPatch)
