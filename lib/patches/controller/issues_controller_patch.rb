module Pwfmt::IssuesControllerPatch
  extend ActiveSupport::Concern

  included do
    before_render :load_wiki_format, only: [:edit, :show]
    before_render :reserve_format, only: [:edit, :show]
  end

  private

  def load_wiki_format
    @issue.load_wiki_format! if @issue.respond_to?(:load_wiki_format!)
  end

  def reserve_format
    Pwfmt::Context.reserve_format('issue_description', @issue.description) if @issue.respond_to?(:description)
  end
end

require 'issues_controller'
IssuesController.__send__(:include, Pwfmt::IssuesControllerPatch)
