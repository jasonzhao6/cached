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
  $.pjax({
    url: '/',
    container: '#content'
  });
});
$('#content').delegate('#reply-tweet-form', 'ajax:success', function(event, data, status, xhr) {
  var url = '/tweets/' + data;
  $.pjax({
    url: url + '?' + appendSearchParams(),
    container: '#content'
  });
});
$('#content').delegate('#edit-tweet-form', 'ajax:success', function(event, data, status, xhr) {
  var url = (params()['origin'] === 'show') ? $(this).attr('action') : '/';
  $.pjax({
    url: url + '?' + appendSearchParams(),
    container: '#content'
  });
});
$('#content').delegate('#new-tweet-form, #reply-tweet-form, #edit-tweet-form', 'ajax:error', function(event, data, status, xhr) {
  alert(data.responseText);
});

// Get quote from twitter for when adding new tweet
// This is called not only here but also on page load in new.html.haml for when page is not loaded via pjax
function getQuote() {
  $.get('/quote', function(data) {
    $('#quote').html(data);
  });
}
$('body').delegate('#content', 'pjax:end', function(event, data, status, xhr) {
  if (data.responseText.indexOf("<p id='quote'></p>") != -1) {
    getQuote();
  }
});

// Hash tag clear button
$('#content').delegate('#clear-hash-tag-btn', 'click', function() {
  $('#hash-tag-field').val('');
  charCount();
});