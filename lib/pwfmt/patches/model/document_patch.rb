module Pwfmt
  module Patches
    module Model
      # This patch extends document that allows load and save wiki format of description
      module DocumentPatch
        extend ActiveSupport::Concern

        included do
          after_save :persist_wiki_format
        end

        # load wiki format of description from database
        def load_wiki_format!
          pwfmt = PwfmtFormat.where(target_id: id, field: 'document_description').first
          description.wiki_format = pwfmt.format if description && pwfmt
        end

        # save wiki format of description to database.
        def persist_wiki_format
          PwfmtFormat.persist(self, 'document_description')
        end
      end
    end
  end
end

require 'document'
Document.__send__(:include, Pwfmt::Patches::Model::DocumentPatch)
