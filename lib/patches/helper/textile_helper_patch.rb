module Pwfmt::TextileHelperPatch
  extend ActiveSupport::Concern
  include Pwfmt::Helper

  included do
    alias_method_chain :wikitoolbar_for, :pwfmt
  end

  def wikitoolbar_for_with_pwfmt(field_id)
    wikitoolbar_for_without_pwfmt(field_id) + javascript_tag(pwfmt_select_script(field_id, 'textile'))
  end
end

Redmine::WikiFormatting::Textile::Helper.send(:include, Pwfmt::TextileHelperPatch)
