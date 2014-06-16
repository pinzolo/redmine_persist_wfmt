module Pwfmt::Helper
  def pwfmt_select_script(field_id, format)
    final_format = Pwfmt::Context.reserved_format_for(field_id) || format
    <<-_EOF_
(function(document) {
  var field = $('##{field_id}');
  if (!document.getElementById('pwfmt-format-#{field_id}')) {
    field.after('<input type="hidden" id="pwfmt-format-#{field_id}" class="pwfmt-format" name="pwfmt[formats][#{field_id}]" value="#{final_format}">');
  }
  if (!document.getElementById('pwfmt-select-#{field_id}')) {
    var select = '<select id="pwfmt-select-#{field_id}" name="pwfmt_select_format" class="pwfmt-select" data-target="#{field_id}">';
    var list = eval('#{Redmine::WikiFormatting.formats_for_select}');
    list.forEach(function(fmt, i) {
      select += '<option value="' + fmt[1] + '">' + fmt[0] + '</option>';
    });
    $('##{field_id}').parent().prev().append(select);
  }
  $('#pwfmt-select-#{field_id}').on('change', function() {
    $('#pwfmt-format-' + this.dataset.target).val($(this).val());
  });
  $('#pwfmt-select-#{field_id}').val('#{final_format}').change();
})(window.document);
    _EOF_
  end
end
