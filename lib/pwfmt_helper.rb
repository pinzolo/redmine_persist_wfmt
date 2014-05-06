module PwfmtHelper
  def pwfmt_select_script(field_id, format)
    <<-_EOF_
(function() {
  var form = document.getElementById('#{field_id}').form;
  $(form).prepend('<input type="hidden" class="pwfmt-format" name="pwfmt[format]" value="#{format}">');
  var select = '<select name="pwfmt_select_format" class="pwfmt-select-format" data-target="#{field_id}">';
  var list = eval('#{Redmine::WikiFormatting.formats_for_select}');
  list.forEach(function(fmt, i) {
    select += '<option value="' + fmt[1] + '">' + fmt[0] + '</option>';
  });
  $('.jstElements').append(select);
  $('.pwfmt-select-format').on('change', function() {
    $(document.getElementById(this.dataset.target).form).children('.pwfmt-format').val($(this).val());
  });
  $('.pwfmt-select-format').val('#{format}');
})();
    _EOF_
  end
end
