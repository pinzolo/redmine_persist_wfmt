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

    def view_settings_general_form(context)
      pwfmt = PwfmtFormat.where(field: 'settings_welcome_text').first
      if pwfmt
        script =<<-_EOF_
(function() {
  $('#pwfmt-select-settings_welcome_text').val('#{pwfmt.format}').change();
})();
        _EOF_
        javascript_tag(script)
      end
    end
  end
end
