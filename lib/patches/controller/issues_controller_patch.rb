module Pwfmt::IssuesControllerPatch
  extend ActiveSupport::Concern

  included do
    before_render :load_wiki_format, only: [:edit, :show]
    before_render :reserve_format, only: [:edit, :show]
  end

  private

  def load_wiki_format
    @issue.load_wiki_format! if @issue.respond_to?(:load_wiki_format!)
    load_journals_wiki_formats if @journals.present?
  end

  def reserve_format
    Pwfmt::Context.reserve_format('issue_description', @issue.description) if @issue.respond_to?(:description)
  end

  def load_journals_wiki_formats
    journal_pwfmts = PwfmtFormat.where(target_id: @journals.map(&:id), field: 'journal_notes')
    journal_formats = Hash[journal_pwfmts.map { |f| [f.target_id, f.format] }]
    @journals.each do |journal|
      journal.notes.wiki_format = journal_formats[journal.id] if journal_formats[journal.id]
    end
  end
end

require 'issues_controller'
IssuesController.__send__(:include, Pwfmt::IssuesControllerPatch)
