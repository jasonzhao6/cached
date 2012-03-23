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