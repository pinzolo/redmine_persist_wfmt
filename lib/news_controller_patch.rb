module Pwfmt::NewsControllerPatch
  extend ActiveSupport::Concern

  included do
    before_filter :load_wiki_format
    before_filter :reserve_format, only: [:show, :edit]
  end

  private

  def load_wiki_format
    if defined?(@news)
      @news.load_wiki_format!
      @news.comments.each(&:load_wiki_format!)
    end
  end

  def reserve_format
    Pwfmt::Context.reserved_format = @news.description.pwfmt.format if @news.description.try(:pwfmt)
  end
end

require 'news_controller'
NewsController.send(:include, Pwfmt::NewsControllerPatch)


