module Pwfmt::WikiContentVersionPatch
  extend ActiveSupport::Concern

  def load_wiki_format!
    pwfmt = PwfmtFormat.where(target_id: self.wiki_content_id, field: "wiki_content:v#{self.version}").first
    text.pwfmt = pwfmt if text && pwfmt
  end
end

require 'wiki_content'
WikiContent::Version.__send__(:include, Pwfmt::WikiContentVersionPatch)
