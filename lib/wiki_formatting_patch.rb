module Redmine::WikiFormatting
  class << self
    def to_html_with_pwfmt(format, text, options = {})
      if text.respond_to?(:wiki_format) && Redmine::WikiFormatting.format_names.include?(text.wiki_format)
        Rails.logger.debug("[pwfmt-debug] using wiki_format attr")
        to_html_without_pwfmt(text.wiki_format, text, options)
      elsif text.respond_to?(:pwfmt) && text.pwfmt && text.pwfmt.format.present?
        to_html_without_pwfmt(text.pwfmt.format, text, options)
      else
        to_html_without_pwfmt(format, text, options)
      end
    end
    alias_method_chain :to_html, :pwfmt
  end
end
