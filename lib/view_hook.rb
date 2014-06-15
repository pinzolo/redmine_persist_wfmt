module Pwfmt
  class ViewHook < Redmine::Hook::ViewListener
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
