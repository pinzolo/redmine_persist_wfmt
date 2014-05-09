module Pwfmt::WikiContentPatch
  extend ActiveSupport::Concern

  included do
    after_save :persist_wiki_format
  end

  def load_wiki_format!
    pwfmt = PwfmtFormat.where(target_id: self.id, field: "wiki_content:v#{self.version}").first
    text.pwfmt = pwfmt if text && pwfmt
  end

  def persist_wiki_format
    if Pwfmt::Context.formats && Pwfmt::Context.formats.key?('content_text')
      pwfmt = PwfmtFormat.where(target_id: self.id, field: "wiki_content:v#{self.version}").first
      if pwfmt
        pwfmt.update_attributes(format: Pwfmt::Context.formats['content_text'])
      else
        PwfmtFormat.create(target_id: self.id,
                           field: "wiki_content:v#{self.version}",
                           format: Pwfmt::Context.formats['content_text'])
      end
    end
  end
end

require 'wiki_content'
WikiContent.send(:include, Pwfmt::WikiContentPatch)
