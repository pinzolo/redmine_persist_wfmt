module Pwfmt::NewsControllerPatch
  extend ActiveSupport::Concern

  included do
    before_render :load_wiki_format, only: [:edit, :show]
    before_render :load_all_news_wiki_format, only: [:index]
    before_render :reserve_format, only: [:edit, :show]
  end

  private

  def load_wiki_format
    if @news.respond_to?(:load_wiki_format!)
      @news.load_wiki_format!
      @news.comments.each(&:load_wiki_format!)
    end
  end

  def load_all_news_wiki_format
    @newss.each(&:load_wiki_format!) if @newss
  end

  def reserve_format
    Pwfmt::Context.reserve_format('news_description', @news.description) if @news.respond_to?(:description)
  end
end

require 'news_controller'
NewsController.__send__(:include, Pwfmt::NewsControllerPatch)
