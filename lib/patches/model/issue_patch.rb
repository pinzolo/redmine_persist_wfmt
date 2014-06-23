module Pwfmt::IssuePatch
  extend ActiveSupport::Concern

  included do
    after_save :persist_wiki_format
  end

  def load_wiki_format!
    pwfmt = PwfmtFormat.where(target_id: self.id, field: 'issue_description').first
    description.wiki_format = pwfmt.format if description && pwfmt
  end

  def persist_wiki_format
    PwfmtFormat.persist(self, 'issue_description')
  end
end

require 'issue'
Issue.__send__(:include, Pwfmt::IssuePatch)
