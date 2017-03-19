// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/widgets/sortable
//= require tether
//= require bootstrap-sprockets
//= require_tree .

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