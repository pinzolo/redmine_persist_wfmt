module Pwfmt
  # This patch extends project that allows load and save wiki format of description
  module ProjectPatch
    extend ActiveSupport::Concern

    included do
      after_save :persist_wiki_format
      prepend ShortDescription
    end

    # This patch extends 'Project#short_description'
    module ShortDescription
      # short_description returns new string instance, so need set wiki format to return value.
      def short_description(length = 255)
        super(length).tap do |short_desc|
          if short_desc
            load_wiki_format! unless description.try(:wiki_format)
            short_desc.wiki_format = description.wiki_format
          end
        end
      end
    end

    # load wiki format of description from database
    def load_wiki_format!
      pwfmt = PwfmtFormat.where(target_id: id, field: 'project_description').first
      description.wiki_format = pwfmt.format if description && pwfmt
    end

    # save wiki format of description to database.
    def persist_wiki_format
      PwfmtFormat.persist(self, 'project_description')
    end
  end
end

require 'project'
Project.__send__(:include, Pwfmt::ProjectPatch)
