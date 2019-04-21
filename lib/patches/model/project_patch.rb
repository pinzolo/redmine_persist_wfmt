module Pwfmt::ProjectPatch
  extend ActiveSupport::Concern

  included do
    after_save :persist_wiki_format
    prepend ShortDescription
  end

  module ShortDescription
    def short_description(length = 255)
      super(length).tap do |short_desc|
        if short_desc
          load_wiki_format! unless description.try(:wiki_format)
          short_desc.wiki_format = description.wiki_format
        end
      end
    end
  end

  def load_wiki_format!
    pwfmt = PwfmtFormat.where(target_id: self.id, field: 'project_description').first
    description.wiki_format = pwfmt.format if description && pwfmt
  end

  def persist_wiki_format
    PwfmtFormat.persist(self, 'project_description')
  end
end

require 'project'
Project.__send__(:include, Pwfmt::ProjectPatch)
