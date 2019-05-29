module Pwfmt
  # This patch extends markdown helper
  module MarkdownHelperPatch
    include Pwfmt::Helper

    # append dropdown for selecting format.
    def wikitoolbar_for(field_id, preview_url = preview_text_path)
      super(field_id, preview_url) + javascript_tag(pwfmt_select_script(field_id, 'markdown'))
    end

    # overrides toolbar script for switching action by selected format.
    def heads_for_wiki_formatter
      super

      return if @pwfmt_heads_for_wiki_formatter_included

      content_for :header_tags do
        javascript_include_tag('toolbar', plugin: 'redmine_persist_wfmt')
      end
      @pwfmt_heads_for_wiki_formatter_included = true
    end
  end
end

Redmine::WikiFormatting::Markdown::Helper.prepend(Pwfmt::MarkdownHelperPatch)
