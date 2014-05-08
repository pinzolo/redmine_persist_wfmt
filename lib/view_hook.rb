module Pwfmt
  class ViewHook < Redmine::Hook::ViewListener
    def view_projects_form(context)
      project = context[:project]
      if project && project.description.try(:pwfmt)
        script =<<-_EOF_
(function() {
  $('#pwfmt-select-project_description').val('#{project.description.pwfmt.format}').change();
})();
        _EOF_
        javascript_tag(script)
      end
    end

    def view_issues_form_details_bottom(context)
      issue = context[:issue]
      if issue && issue.description.try(:pwfmt)
        script =<<-_EOF_
(function() {
  $('#pwfmt-select-issue_description').val('#{issue.description.pwfmt.format}').change();
})();
        _EOF_
        javascript_tag(script)
      end
    end

    def view_journals_notes_form_after_notes(context)
      journal = context[:journal]
      Pwfmt::Context.reserved_format = journal.notes.pwfmt.format if journal && journal.notes.try(:pwfmt)
    end
  end
end
