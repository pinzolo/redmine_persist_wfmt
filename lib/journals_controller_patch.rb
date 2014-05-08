module Pwfmt::JournalsControllerPatch
  extend ActiveSupport::Concern

  included do
    before_filter :load_wiki_format
  end

  private

  def load_wiki_format
    @journal.load_wiki_format! if defined?(@journal)
  end
end

if require "journals_controller"
  JournalsController.send(:include, Pwfmt::JournalsControllerPatch)
end

