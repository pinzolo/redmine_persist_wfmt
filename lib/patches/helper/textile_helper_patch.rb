module Pwfmt::TextileHelperPatch
  include Pwfmt::Helper

  def wikitoolbar_for(field_id, preview_url = preview_text_path)
    super(field_id, preview_url) + javascript_tag(pwfmt_select_script(field_id, 'textile'))
  end

  def heads_for_wiki_formatter
    Rails.logger.debug("pwfmt: #{@heads_for_wiki_formatter_included}")
    unless @heads_for_wiki_formatter_included
      content_for :header_tags do
        javascript_include_tag('jstoolbar/jstoolbar') +
        javascript_include_tag('toolbar', plugin: 'redmine_persist_wfmt') +
        javascript_include_tag("jstoolbar/lang/jstoolbar-#{current_language.to_s.downcase}") +
        javascript_tag("var wikiImageMimeTypes = #{Redmine::MimeType.by_type('image').to_json};") +
        stylesheet_link_tag('jstoolbar')
      end
      @heads_for_wiki_formatter_included = true
    end
  end
end

Redmine::WikiFormatting::Textile::Helper.prepend(Pwfmt::TextileHelperPatch)
