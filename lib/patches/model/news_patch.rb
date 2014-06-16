module Pwfmt::NewsPatch
  extend ActiveSupport::Concern

  included do
    after_save :persist_wiki_format
  end

  def load_wiki_format!
    pwfmt = PwfmtFormat.where(target_id: self.id, field: 'news_description').first
    description.wiki_format = pwfmt.format if description && pwfmt
  end

  def persist_wiki_format
    PwfmtFormat.persist(self, 'news_description')
  end
end

require 'news'
News.__send__(:include, Pwfmt::NewsPatch)
