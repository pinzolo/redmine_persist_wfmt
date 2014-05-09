module Pwfmt::MessagePatch
  extend ActiveSupport::Concern

  included do
    after_save :persist_wiki_format
  end

  def load_wiki_format!
    pwfmt = PwfmtFormat.where(target_id: self.id, field: 'message_content').first
    content.pwfmt = pwfmt if content && pwfmt
  end

  def persist_wiki_format
    if Pwfmt::Context.formats && Pwfmt::Context.formats.key?('message_content')
      pwfmt = PwfmtFormat.where(target_id: self.id, field: 'message_content').first
      if pwfmt
        pwfmt.update_attributes(format: Pwfmt::Context.formats['message_content'])
      else
        PwfmtFormat.create(target_id: self.id,
                           field: 'message_content',
                           format: Pwfmt::Context.formats['message_content'])
      end
    end
  end
end

require 'message'
Message.send(:include, Pwfmt::MessagePatch)
