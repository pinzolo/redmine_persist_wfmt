module Pwfmt::WikiControllerPatch
  extend ActiveSupport::Concern

  included do
    before_render :load_wiki_format, only: [:edit, :show]
    before_render :reserve_format, only: [:edit]
  end

  private

  def load_wiki_format
    @content.load_wiki_format! if @content.respond_to?(:load_wiki_format!)
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
