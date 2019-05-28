# helper module for using in views
module Pwfmt::Helper
  def pwfmt_select_script(field_id, wiki_format)
    format = Pwfmt::Context.reserved_format_for(field_id) || wiki_format
    <<~_EOF_
      (function(doc, toolbar) {
        pwfmt.insertFormatHidden(doc, '#{field_id}', '#{format}');
        var formats = #{Redmine::WikiFormatting.formats_for_select};
        pwfmt.insertFormatSelector(doc, '#{field_id}', '#{format}', formats, toolbar);
      })(window.document, wikiToolbar);
    _EOF_
  end
end
