module Pwfmt
  module Patches
    module Model
      # This patch extends journal that allows load and save wiki format of note
      module JournalPatch
        extend ActiveSupport::Concern

        included do
          after_save :persist_wiki_format
        end

        # load wiki format of note from database
        def load_wiki_format!
          pwfmt = PwfmtFormat.where(target_id: id, field: 'journal_notes').first
          notes.wiki_format = pwfmt.format if notes && pwfmt
        end

        # save wiki format of note to database.
        def persist_wiki_format
          if Pwfmt::Context.format_for?('issue_notes')
            PwfmtFormat.persist(self, 'journal_notes', Pwfmt::Context.format_for('issue_notes'))
          elsif Pwfmt::Context.format_for?("journal_#{id}_notes")
            PwfmtFormat.persist(self, 'journal_notes', Pwfmt::Context.format_for("journal_#{id}_notes"))
          end
        end
      end
    end
  end
end

require 'journal'
Journal.__send__(:include, Pwfmt::Patches::Model::JournalPatch)
