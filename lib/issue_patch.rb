module Pwfmt::IssuePatch
  extend ActiveSupport::Concern

  included do
    after_save :persist_wiki_format
  end

  def load_wiki_format!
    pwfmt = PwfmtFormat.where(target_id: self.id, field: 'issue_description').first
    description.pwfmt = pwfmt if description && pwfmt
  end

  def persist_wiki_format
    if Pwfmt::Context.formats && Pwfmt::Context.formats.key?('issue_description')
      pwfmt = PwfmtFormat.where(target_id: self.id, field: 'issue_description').first
      if pwfmt
        pwfmt.update_attributes(format: Pwfmt::Context.formats['issue_description'])
      else
        PwfmtFormat.create(target_id: self.id,
                           field: 'issue_description',
                           format: Pwfmt::Context.formats['issue_description'])
      end
    end
  end
end

if require 'issue'
  Issue.send(:include, Pwfmt::IssuePatch)
end
