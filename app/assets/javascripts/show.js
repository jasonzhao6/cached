// gallerySetup() binding, not only here but also on page load when not loaded via pjax (see page source)
function gallerySetup() {
  var slides = $('#slider li');
  var bullets = $('#position li');
  window.mySwipe = new Swipe(
    document.getElementById('slider'),
    {
      startSlide: parseInt($('#start-index').val()),
      callback: function(e, pos) {
        // Update bullets
        var i = bullets.length;
        while (i--) {
          bullets[i].className = '';
        }
        bullets[pos].className = 'active';
        // Update form actions
        var id = slides[pos].id;
        $('.reply-btn').attr('href', '/tweets/' + id + '/reply?origin=show' + appendSearchParams())
        $('.edit-btn').attr('href', '/tweets/' + id + '/edit?origin=show' + appendSearchParams())
      }
    }
  );
}
$('body').delegate('#content', 'pjax:success', function(e, xhr, err) {
  if ($('#gallery').length > 0) {
    gallerySetup();
  }
});