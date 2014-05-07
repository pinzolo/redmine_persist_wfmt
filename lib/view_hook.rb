module Pwfmt
  class ViewHook < Redmine::Hook::ViewListener
    def view_projects_form(context)
      project = context[:project]
      if project && project.description.try(:pwfmt)
        script =<<-_EOF_
(function() {
  $('.pwfmt-select-format').val('#{project.description.pwfmt.format}').change();
})();
        _EOF_
        javascript_tag(script)
      end
    end
  end
end
