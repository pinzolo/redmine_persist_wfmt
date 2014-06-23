module Pwfmt::MessagePatch
  extend ActiveSupport::Concern

  included do
    after_save :persist_wiki_format
  end

  def load_wiki_format!
    pwfmt = PwfmtFormat.where(target_id: self.id, field: 'message_content').first
    content.wiki_format = pwfmt.format if content && pwfmt
  end

  def persist_wiki_format
    PwfmtFormat.persist(self, 'message_content')
  end
end

require 'message'
Message.__send__(:include, Pwfmt::MessagePatch)
