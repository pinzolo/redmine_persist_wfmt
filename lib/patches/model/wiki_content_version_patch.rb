# This patch extends wiki version that allows load and save wiki format of content
module Pwfmt::WikiContentVersionPatch
  extend ActiveSupport::Concern

  # load wiki format of content from database
  def load_wiki_format!
    pwfmt = PwfmtFormat.where(target_id: self.wiki_content_id, field: "wiki_content:v#{self.version}").first
    text.wiki_format = pwfmt.format if text && pwfmt
  end
end

require 'wiki_content'
WikiContent::Version.__send__(:include, Pwfmt::WikiContentVersionPatch)
