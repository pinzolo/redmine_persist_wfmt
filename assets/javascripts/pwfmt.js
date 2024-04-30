if (window.pwfmt == null) {
  window.pwfmt = {
    insertFormatHidden: function(doc, fieldId, format) {
      var hiddenId = 'pwfmt-format-' + fieldId;
      if (doc.getElementById(hiddenId) != null) {
        return;
      }
      var field = doc.getElementById(fieldId);
      var hidden = doc.createElement('input');
      hidden.type = 'hidden';
      hidden.id = hiddenId;
      hidden.className = 'pwfmt-format';
      hidden.name = 'pwfmt[formats][' + fieldId + ']';
      hidden.value = format;
      field.parentNode.appendChild(hidden);
    },
    insertFormatSelector: function(doc, fieldId, format, formats, toolbar) {
      var selectorId = 'pwfmt-select-' + fieldId;
      if (doc.getElementById(selectorId) != null) {
        return;
      }

      var select = doc.createElement('select');
      select.id = selectorId;
      select.className = 'pwfmt-select';
      select.dataset.target = fieldId;
      formats.forEach(function(fmt) {
        var opt = doc.createElement('option');
        opt.value = fmt[1];
        opt.text = fmt[0];
        opt.selected = opt.value === format;
        select.options.add(opt);
      });
      select.addEventListener(
        'change',
        function() {
          var hidden = doc.getElementById('pwfmt-format-' + fieldId);
          if (hidden == null) {
            return;
          }
          hidden.value = this.options[this.selectedIndex].value;
        },
        false
      );
      toolbar.formatSelector = select;
      toolbar.toolbar.append(select);
    },
    isMarkdownSelected: function(toolbar) {
      var idx = toolbar.formatSelector.selectedIndex;
      const markdownFormats = ['markdown', 'common_mark']
      return markdownFormats.includes(toolbar.formatSelector.options[idx].value);
    }
  };
}

$(document).ready(function() {
  $('#content').off('click', 'div.jstTabs a.tab-preview');
  $('#content').on('click', 'div.jstTabs a.tab-preview', function(event) {
    var tab = $(event.target);

    var url = tab.data('url');
    var form = tab.parents('form');
    var jstBlock = tab.parents('.jstBlock');

    var element = encodeURIComponent(jstBlock.find('.wiki-edit').val());
    var attachments = form.find('.attachments_fields input').serialize();

    var format = jstBlock.find('.pwfmt-select').val();

    $.ajax({
      url: url,
      type: 'post',
      data: 'pwfmt_format=' + format + '&text=' + element + '&' + attachments,
      success: function(data) {
        jstBlock.find('.wiki-preview').html(data);
      }
    });
  });
});
