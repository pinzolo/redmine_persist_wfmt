module Pwfmt::ProjectPatch
  extend ActiveSupport::Concern

  included do
    after_save :persist_wiki_format
    alias_method_chain :short_description, :pwfmt
  end

  def short_description_with_pwfmt(length = 255)
    short_description_without_pwfmt(length).tap do |short_desc|
      if short_desc
        load_wiki_format! unless description.try(:pwfmt)
        short_desc.pwfmt = description.pwfmt
      end
    end
  end

  def load_wiki_format!
    pwfmt = PwfmtFormat.where(target_id: self.id, field: 'project_description').first
    description.pwfmt = pwfmt if description && pwfmt
  end

  def persist_wiki_format
    if Pwfmt::Context.formats && Pwfmt::Context.formats.key?('project_description')
      pwfmt = PwfmtFormat.where(target_id: self.id, field: 'project_description').first
      if pwfmt
        pwfmt.update_attributes(format: Pwfmt::Context.formats['project_description'])
      else
        PwfmtFormat.create(target_id: self.id,
                           field: 'project_description',
                           format: Pwfmt::Context.formats['project_description'])
      end
    end
  end
end

if require 'project'
  Project.send(:include, Pwfmt::ProjectPatch)
end
