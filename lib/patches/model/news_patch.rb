# This patch extends news that allows load and save wiki format of description
module Pwfmt::NewsPatch
  extend ActiveSupport::Concern

  included do
    after_save :persist_wiki_format
  end

  # load wiki format of description from database
  def load_wiki_format!
    pwfmt = PwfmtFormat.where(target_id: self.id, field: 'news_description').first
    description.wiki_format = pwfmt.format if description && pwfmt
  end

  # save wiki format of description to database.
  def persist_wiki_format
    PwfmtFormat.persist(self, 'news_description')
  end
end

require 'news'
News.__send__(:include, Pwfmt::NewsPatch)
