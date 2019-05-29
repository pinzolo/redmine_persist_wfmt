module Pwfmt
  # This patch extends wiki that allows load and save wiki format of content
  module WikiContentPatch
    extend ActiveSupport::Concern

    included do
      after_save :persist_wiki_format
    end

    # load wiki format of content from database
    def load_wiki_format!
      pwfmt = PwfmtFormat.where(target_id: id, field: "wiki_content:v#{version}").first
      text.wiki_format = pwfmt.format if text && pwfmt
    end

    # save wiki format of content to database.
    def persist_wiki_format
      PwfmtFormat.persist(self, "wiki_content:v#{version}", Pwfmt::Context.format_for('content_text'))
    end
  end
end

require 'wiki_content'
WikiContent.__send__(:include, Pwfmt::WikiContentPatch)
