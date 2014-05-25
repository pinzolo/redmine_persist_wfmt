module Pwfmt::JournalsControllerPatch
  extend ActiveSupport::Concern

  included do
    before_filter :load_wiki_format
    before_filter :reserve_format, only: [:edit]
  end

  private

  def load_wiki_format
    @journal.load_wiki_format! if defined?(@journal)
  end

  def reserve_format
    Pwfmt::Context.reserve_format("journal_#{@journal.id}_notes", @journal.notes)
  end
end

require 'journals_controller'
JournalsController.send(:include, Pwfmt::JournalsControllerPatch)
