module Pwfmt::WikiContentPatch
  extend ActiveSupport::Concern

  included do
    after_save :persist_wiki_format
  end

  def load_wiki_format!
    pwfmt = PwfmtFormat.where(target_id: self.id, field: "wiki_content:v#{self.version}").first
    text.wiki_format = pwfmt.format if text && pwfmt
  end

  def persist_wiki_format
    PwfmtFormat.persist(self, "wiki_content:v#{self.version}", Pwfmt::Context.format_for('content_text'))
  end
end

require 'wiki_content'
WikiContent.__send__(:include, Pwfmt::WikiContentPatch)
