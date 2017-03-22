function updatePageSelectVisibility($form) {
  var itemType = $form.find('select[name="navigation_item[item_type]"]').val();
  var pageSelect = $form.find('select[name="navigation_item[page_id]"]');

  if (itemType === 'section') {
    pageSelect.val(null);
    pageSelect.closest('.form-group').hide();
  } else if (itemType === 'link') {
    pageSelect.closest('.form-group').show();
  }
}

$(function() {
  $('.navigation-item-list').sortable({
    items: '.list-group-item',
    handle: '.drag-handle',
    update: function(event, ui) {
      var list = $(event.target);
      var items = list.find('.list-group-item');
      var newOrder = items.map(function() { return $(this).data('navigation-item-id') }).toArray();

      $.ajax(list.data('sort-url'), {
        method: 'PATCH',
        data: {
          navigation_item_ids: newOrder
        }
      });
    }
  });

  $('.navigation_item_form').each(function() {
    var $form = $(this);
    updatePageSelectVisibility($form);

    $form.on('change', 'select[name="navigation_item[item_type]"]', function() { updatePageSelectVisibility($form); });
  });
});