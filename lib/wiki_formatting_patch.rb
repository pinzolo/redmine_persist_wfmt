module Redmine::WikiFormatting
  class << self
    def to_html_with_pwfmt(format, text, options = {})
      if text.respond_to?(:pwfmt) && text.pwfmt
        to_html_without_pwfmt(text.pwfmt.format, text, options)
      else
        to_html_without_pwfmt(format, text, options)
      end
    end
    alias_method_chain :to_html, :pwfmt
  end
end
