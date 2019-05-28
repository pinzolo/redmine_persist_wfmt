# This patch extends message that allows load and save wiki format of content
module Pwfmt::MessagePatch
  extend ActiveSupport::Concern

  included do
    after_save :persist_wiki_format
  end

  # load wiki format of content from database
  def load_wiki_format!
    pwfmt = PwfmtFormat.where(target_id: id, field: 'message_content').first
    content.wiki_format = pwfmt.format if content && pwfmt
  end

  # save wiki format of content to database.
  def persist_wiki_format
    PwfmtFormat.persist(self, 'message_content')
  end
end

require 'message'
Message.__send__(:include, Pwfmt::MessagePatch)
