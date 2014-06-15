module Pwfmt::NewsControllerPatch
  extend ActiveSupport::Concern

  included do
    before_render :load_wiki_format, only: [:edit, :show]
    before_render :reserve_format, only: [:edit, :show]
  end

  private

  def load_wiki_format
    @news.load_wiki_format!
    @news.comments.each(&:load_wiki_format!)
  end

  def reserve_format
    Pwfmt::Context.reserve_format('news_description', @news.description)
  end
end

require 'news_controller'
NewsController.send(:include, Pwfmt::NewsControllerPatch)
