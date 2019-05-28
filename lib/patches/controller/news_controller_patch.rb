# This patch extends NewsController.
# This patch enables to load user selected format of news description and comments.
# And enables to save selected format of news description.
module Pwfmt::NewsControllerPatch
  extend ActiveSupport::Concern

  included do
    before_render :load_wiki_format, only: %i[edit show]
    before_render :load_all_news_wiki_format, only: :index
    before_render :reserve_format, only: %i[edit show]
  end

  private

  # load wiki format of itself and comments from database
  def load_wiki_format
    return unless @news.respond_to?(:load_wiki_format!)

    @news.load_wiki_format!
    @news.comments.each(&:load_wiki_format!)
  end

  # load wiki format of journals from database
  def load_all_news_wiki_format
    @newss&.each(&:load_wiki_format!)
  end

  # store wiki format of itself to database
  def reserve_format
    Pwfmt::Context.reserve_format('news_description', @news.description) if @news.respond_to?(:description)
  end
end

require 'news_controller'
NewsController.__send__(:include, Pwfmt::NewsControllerPatch)
