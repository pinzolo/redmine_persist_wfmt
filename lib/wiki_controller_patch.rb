module Pwfmt::WikiControllerPatch
  extend ActiveSupport::Concern

  included do
    before_filter :reserve_format, only: [:edit]
  end

  private
  def reserve_format
    if @page.content
      @page.content.load_wiki_format!
      Pwfmt::Context.reserve_format('content_text', @page.content.text)
    end
  end
end

require 'wiki_controller'
WikiController.send(:include, Pwfmt::WikiControllerPatch)
