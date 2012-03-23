// Count number of characters when typing in either tweet or hashtag field
function charCount() {
  var length = $('#tweet-field').val().length + $('#hash-tag-field').val().length + 2;
  var $charCount = $('#char-count');
  $charCount.text(length);
  if (length <= 140) {
    $charCount.css('color', 'black');
  } else {
    $charCount.css('color', 'red');
  }
}
$('#content').delegate('#tweet-field', 'keyup', function() {
  charCount();
});
$('#content').delegate('#tweet-field', 'blur', function() {
  var $tweetField = $('#tweet-field');
  $tweetField.val($.trim($tweetField.val()));
  charCount();
});
$('#content').delegate('#hash-tag-field', 'blur', function() {
  // Delay trim and charCount until Typeahead finishes autocompleting
  setTimeout(function() {
    var $hashTagField = $('#hash-tag-field');
    $hashTagField.val($hashTagField.val().replace(/ /g, '').toLowerCase());
    charCount();
  }, 200);
});

// Unobtrusive form, not necessary, but it makes server-side validation nice (error feedback without page refresh)
$('#content').delegate('#new-tweet-form', 'ajax:success', function(event, data, status, xhr) {
});
$('#content').delegate('#reply-tweet-form', 'ajax:success', function(event, data, status, xhr) {
  var url = '/tweets/' + data;
});
$('#content').delegate('#edit-tweet-form', 'ajax:success', function(event, data, status, xhr) {
  var url = (params()['origin'] === 'show') ? $(this).attr('action') : '/';
});
$('#content').delegate('#new-tweet-form, #reply-tweet-form, #edit-tweet-form', 'ajax:error', function(event, data, status, xhr) {
  alert(data.responseText);
});