module Pwfmt::CommentPatch
  extend ActiveSupport::Concern

  included do
    after_save :persist_wiki_format
  end

  def load_wiki_format!
    pwfmt = PwfmtFormat.where(target_id: self.id, field: 'comment_comments').first
    comments.pwfmt = pwfmt if comments && pwfmt
  end

  def persist_wiki_format
    if Pwfmt::Context.formats && Pwfmt::Context.formats.key?('comment_comments')
      pwfmt = PwfmtFormat.where(target_id: self.id, field: 'comment_comments').first
      if pwfmt
        pwfmt.update_attributes(format: Pwfmt::Context.formats['comment_comments'])
      else
        PwfmtFormat.create(target_id: self.id,
                           field: 'comment_comments',
                           format: Pwfmt::Context.formats['comment_comments'])
      end
    end
  end
end

require 'comment'
Comment.send(:include, Pwfmt::CommentPatch)
