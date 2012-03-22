// Ajax search
function search() {
  $.ajax({
    url: '/?q=' + escape($('#search-field').val()),
    headers: {
      'X-AJAX': true
    },
    success: function(data) {
      $('#matches').html(data);
    }
  });
}
$('#content').delegate('#search-field', 'keyup', function() {
  var $clearSearch = $('#clear-search-btn');
  if ($(this).val().length > 0) {
    $clearSearch.show();
  } else {
    $clearSearch.hide();
  }
  if ($(this).val().length === 2) {
    var $searchField = $('#search-field');
    if ($searchField.val().toLowerCase() === 'h ') {
      $searchField.val('#');
    }
  }
  
  if (typeof(searchId) === 'number') {
    clearTimeout(searchId);
    searchId = null;
  }
  searchId = setTimeout(search, 450);
});
$('#content').delegate('#clear-search-btn', 'click', function() {
  $('#search-field').val('');
  $('#clear-search-btn').hide();
  search();
});
$('#content').delegate('.form-search', 'submit', function(e) {
  e.preventDefault();
});

// Pjax pagination binding
// params: { data: [html], direction: 'forward' | 'backword' }
// $.fn.slideIn = function(options) {
//   var el = this;
//   var forward = options.direction === 'forward';
//   var width = el.width();
//   var transfer = $('<div></div>').width(2 * width).css({ marginLeft: forward ? 0 : -width });
//   var current = $('<div></div>').width(width).css({ left: 0, float: 'left' }).html(el.html());
//   var next = $('<div></div>').width(width).css({ left: width, float: 'left' }).html(options.data);
//   forward ? transfer.append(current, next) : transfer.append(next, current);
//   el.html(transfer);
//   transfer.animate({ marginLeft: forward ? -width : 0 }, 250, function () {
//     el.html(options.data);
//   });
// }
function paginate() {
  // slideIn is too expensive to render, this is a light weight substitute
  $('#content').html($('#to-paginate').html());
}
$('#pagination a').pjax('#to-paginate');
$('body').delegate('#to-paginate', 'pjax:start', function(e, xhr, err) {
  $('body, html').animate({ scrollTop: 0 }, 350);
});
$('body').delegate('#to-paginate', 'pjax:complete', function(e, xhr, err) {
  setTimeout(paginate, 75); // slight pause between scrollTop and content swap
});