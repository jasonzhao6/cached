// Unobtrusive form, not necessary, but it makes server-side validation nice (error feedback without page refresh)
$('#content').delegate('#session-form', 'ajax:success', function(event, data, status, xhr) {
  window.location = '/'
});
$('#content').delegate('#session-form', 'ajax:error', function(event, data, status, xhr) {
  alert(data.responseText);
});

// Sign up
$('#login').click(function() {
  $('#session-form').attr('action', '/login');
});
$('#sign-up').click(function() {
  $('#session-form').attr('action', '/sign_up').submit();
});