require 'document'
class Document
  after_save :persist_wiki_format

  def load_wiki_format!
    pwfmt = PwfmtFormat.where(target_id: self.id, field: 'document_description').first
    description.pwfmt = pwfmt if description && pwfmt
  end

  def persist_wiki_format
    if Pwfmt::Context.formats && Pwfmt::Context.formats.key?('document_description')
      pwfmt = PwfmtFormat.where(target_id: self.id, field: 'document_description').first
      if pwfmt
        pwfmt.update_attributes(format: Pwfmt::Context.formats['document_description'])
      else
        PwfmtFormat.create(target_id: self.id,
                           field: 'document_description',
                           format: Pwfmt::Context.formats['document_description'])
      end
    end
  end
end
