module Pwfmt::JournalPatch
  extend ActiveSupport::Concern

  included do
    after_save :persist_wiki_format
  end

  def load_wiki_format!
    pwfmt = PwfmtFormat.where(target_id: self.id, field: 'journal_notes').first
    notes.pwfmt = pwfmt if notes && pwfmt
  end

  def persist_wiki_format
    if Pwfmt::Context.formats
      if Pwfmt::Context.formats.key?('issue_notes')
        PwfmtFormat.create(target_id: self.id,
                           field: 'journal_notes',
                           format: Pwfmt::Context.formats['issue_notes'])
      elsif Pwfmt::Context.formats.key?("journal_#{self.id}_notes")
        pwfmt = PwfmtFormat.where(target_id: self.id, field: 'journal_notes').first
        if pwfmt
          pwfmt.update_attributes(format: Pwfmt::Context.formats["journal_#{self.id}_notes"])
        else
          PwfmtFormat.create(target_id: self.id,
                             field: 'journal_notes',
                             format: Pwfmt::Context.formats["journal_#{self.id}_notes"])
        end
      end
    end
  end
end

require 'journal'
Journal.send(:include, Pwfmt::JournalPatch)
