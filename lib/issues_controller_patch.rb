module Pwfmt::IssuesControllerPatch
  extend ActiveSupport::Concern

  included do
    before_filter :load_wiki_format
  end

  private

  def load_wiki_format
    @issue.load_wiki_format! if defined?(@issue)
  end
end

require "issues_controller"
IssuesController.send(:include, Pwfmt::IssuesControllerPatch)

