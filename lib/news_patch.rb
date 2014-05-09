module Pwfmt::NewsPatch
  extend ActiveSupport::Concern

  included do
    after_save :persist_wiki_format
  end

  def load_wiki_format!
    pwfmt = PwfmtFormat.where(target_id: self.id, field: 'news_description').first
    description.pwfmt = pwfmt if description && pwfmt
  end

  def persist_wiki_format
    if Pwfmt::Context.formats && Pwfmt::Context.formats.key?('news_description')
      pwfmt = PwfmtFormat.where(target_id: self.id, field: 'news_description').first
      if pwfmt
        pwfmt.update_attributes(format: Pwfmt::Context.formats['news_description'])
      else
        PwfmtFormat.create(target_id: self.id,
                           field: 'news_description',
                           format: Pwfmt::Context.formats['news_description'])
      end
    end
  end
end

require 'news'
News.send(:include, Pwfmt::NewsPatch)
