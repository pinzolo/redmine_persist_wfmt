module Redmine::WikiFormatting::Textile::Helper
  include PwfmtHelper

  def wikitoolbar_for_with_pwfmt(field_id)
    wikitoolbar_for_without_pwfmt(field_id) + javascript_tag(pwfmt_select_script(field_id, 'textile'))
  end
  alias_method_chain :wikitoolbar_for, :pwfmt
end

