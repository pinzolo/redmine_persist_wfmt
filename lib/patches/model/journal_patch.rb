module Pwfmt::JournalPatch
  extend ActiveSupport::Concern

  included do
    after_save :persist_wiki_format
  end

  def load_wiki_format!
    pwfmt = PwfmtFormat.where(target_id: self.id, field: 'journal_notes').first
    notes.wiki_format = pwfmt.format if notes && pwfmt
  end

  def persist_wiki_format
    if Pwfmt::Context.has_format_for?('issue_notes')
      PwfmtFormat.persist(self, 'journal_notes', Pwfmt::Context.format_for('issue_notes'))
    elsif Pwfmt::Context.has_format_for?("journal_#{self.id}_notes")
      PwfmtFormat.persist(self, 'journal_notes', Pwfmt::Context.format_for("journal_#{self.id}_notes"))
    end
  end
end

require 'journal'
Journal.__send__(:include, Pwfmt::JournalPatch)
