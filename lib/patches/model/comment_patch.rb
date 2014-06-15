module Pwfmt::CommentPatch
  extend ActiveSupport::Concern

  included do
    after_save :persist_wiki_format
  end

  def load_wiki_format!
    pwfmt = PwfmtFormat.where(target_id: self.id, field: 'comment_comments').first
    comments.wiki_format = pwfmt.format if comments && pwfmt
  end

  def persist_wiki_format
    PwfmtFormat.persist(self, 'comment_comments')
  end
end

require 'comment'
Comment.send(:include, Pwfmt::CommentPatch)
