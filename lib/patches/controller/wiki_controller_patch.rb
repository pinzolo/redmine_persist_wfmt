module Pwfmt::WikiControllerPatch
  extend ActiveSupport::Concern

  included do
    before_render :load_wiki_format, only: [:edit, :show]
    before_render :reserve_format, only: [:edit]
    before_render :set_wiki_format_for_preview, only: [:preview]
  end

  private

  def load_wiki_format
    @content.load_wiki_format! if @content.respond_to?(:load_wiki_format!)
  end

  def set_wiki_format_for_preview
    @text.wiki_format = Pwfmt::Context.format_for('content_text') if @text
  end

  def reserve_format
    if @text && @content
      @text.wiki_format = @content.text.wiki_format
      Pwfmt::Context.reserve_format('content_text', @text)
    end
  end
end

require 'wiki_controller'
WikiController.__send__(:include, Pwfmt::WikiControllerPatch)
