$(document).ready(function() {
  $('#content').on('click', 'div.jstTabs a.pwfmt-preview', function(event) {
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
