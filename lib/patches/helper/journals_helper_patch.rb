module Pwfmt::JournalsHelperPatch
  extend ActiveSupport::Concern

  included do
    alias_method_chain :render_notes, :pwfmt
  end

  def render_notes_with_pwfmt(issue, journal, options={})
    journal.load_wiki_format!
    render_notes_without_pwfmt(issue, journal, options)
  end
end

require 'journals_helper'
JournalsHelper.send(:include, Pwfmt::JournalsHelperPatch)
