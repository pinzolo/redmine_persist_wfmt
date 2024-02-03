module Pwfmt
  module Patches
    module Model
      # This patch extends comment that allows load and save wiki format of comment
      module CommentPatch
        extend ActiveSupport::Concern

        included do
          after_save :persist_wiki_format
        end

        # load wiki format of comment from database
        def load_wiki_format!
          pwfmt = PwfmtFormat.where(target_id: id, field: 'comment_comments').first
          comments.wiki_format = pwfmt.format if comments && pwfmt
        end

        # save wiki format of comment to database.
        def persist_wiki_format
          PwfmtFormat.persist(self, 'comment_comments')
        end
      end
    end
  end
end

require 'comment'
Comment.__send__(:include, Pwfmt::Patches::Model::CommentPatch)
