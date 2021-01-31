module Pwfmt
  # This patch extends IssuesController.
  # This patch enables to load user selected format of issue description and journals.
  # And enables to save selected format of issue description.
  module IssuesControllerPatch
    extend ActiveSupport::Concern

    included do
      before_render :load_wiki_format, only: %i[edit show]
      before_render :reserve_format, only: %i[edit show]
    end

    private

    # load wiki format of itself and jounals from database
    def load_wiki_format
      @issue.load_wiki_format! if @issue.respond_to?(:load_wiki_format!)
      load_journals_wiki_formats if @journals.present?
    end

    # store wiki format of itself to database
    def reserve_format
      Pwfmt::Context.reserve_format('issue_description', @issue.description) if @issue.respond_to?(:description)
    end

    # load wiki format of journals from database
    def load_journals_wiki_formats
      journal_pwfmts = PwfmtFormat.where(target_id: @journals.map(&:id), field: 'journal_notes')
      journal_formats = Hash[journal_pwfmts.map { |f| [f.target_id, f.format] }]
      @journals.each do |journal|
        unless journal.notes.nil?
          journal.notes.wiki_format = journal_formats[journal.id] if journal_formats[journal.id]
        end   
      end
    end
  end
end

require 'issues_controller'
IssuesController.__send__(:include, Pwfmt::IssuesControllerPatch)
