// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery.stack
//= require twitter/bootstrap
//= require underscore
//= require backbone
//= require backbone_rails_sync
//= require backbone_datalink
//= require backbone/cached
//= require_tree .

// Url bar hiding
(function() {
  var win = window,
      doc = win.document;
  // If there's a hash, or addEventListener is undefined, stop here
  if ( !location.hash || !win.addEventListener ) {
    //scroll to 0
    window.scrollTo( 0, 0 );
    var scrollTop = 0,
    //reset to 0 on bodyready, if needed
    bodycheck = setInterval(function(){
      if( doc.body ){
        clearInterval( bodycheck );
        scrollTop = "scrollTop" in doc.body ? doc.body.scrollTop : 0;
        win.scrollTo( 0, scrollTop === 0 ? 0 : 0 );
      } 
    }, 05 );
    if (win.addEventListener) {
      win.addEventListener("load", function(){
        setTimeout(function(){
          //reset to hide addr bar at onload
          win.scrollTo( 0, scrollTop === 0 ? 0 : 0 );
        }, 0);
      }, false );
    }
  }
})();

// Url params parsing
function params() {
  var vars = {};
  var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
      vars[key] = value;
  });
  return vars;
}

// Force all article links to open in new window
$('#content').delegate("#article-show article a, [contenteditable='true'] a", 'click', function() {
  window.open($(this).attr('href'));
  return false;
});
