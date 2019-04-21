module Pwfmt::JournalsHelperPatch
  extend ActiveSupport::Concern

  included do
    prepend RenderNotes
  end

  module RenderNotes
    def render_notes(issue, journal, options={})
      journal.load_wiki_format!
      super(issue, journal, options)
    end
  end
end

require 'journals_helper'
JournalsHelper.__send__(:include, Pwfmt::JournalsHelperPatch)
