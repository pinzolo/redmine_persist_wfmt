module Pwfmt::PreviewsControllerPatch
  extend ActiveSupport::Concern

  included do
    before_render :set_issue_wiki_format, only: [:issue]
    before_render :set_news_wiki_format, only: [:news]
  end

  private

  def set_issue_wiki_format
    if @description
      @description.wiki_format = Pwfmt::Context.format_for('issue_description')
    elsif @notes
      if Pwfmt::Context.has_format_for?('issue_notes')
        @notes.wiki_format = Pwfmt::Context.format_for('issue_notes')
      else
        @notes.wiki_format = Pwfmt::Context.formats.first.last
      end
    end
  end

  def set_news_wiki_format
    @text.wiki_format = Pwfmt::Context.format_for('news_description') if @text
  end
end

require 'previews_controller'
PreviewsController.__send__(:include, Pwfmt::PreviewsControllerPatch)
