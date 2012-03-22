// TOUCH-EVENTS SINGLE-FINGER SWIPE-SENSING JAVASCRIPT
// Courtesy of PADILICIOUS.COM and MACOSXAUTOMATION.COM

// this script can be used with one or more page elements to perform actions based on them being swiped with a single finger

var triggerElementID = null; // this variable is used to identity the triggering element
var fingerCount = 0;
var startX = 0;
var startY = 0;
var curX = 0;
var curY = 0;
var deltaX = 0;
var deltaY = 0;
var minLength = 20; // the shortest distance the user may swipe
var swipeLength = 0;
var isScrollingHorizontally = null;

// The 4 Touch Event Handlers

// NOTE: the touchStart handler should also receive the ID of the triggering element
// make sure its ID is passed in the event call placed in the element declaration, like:
// <div id="picture-frame" ontouchstart="touchStart(event,'picture-frame');"  ontouchend="touchEnd(event);" ontouchmove="touchMove(event);" ontouchcancel="touchCancel(event);">

function touchStart(event, passedName) {
  // disable the standard ability to select the touched object
  // get the total number of fingers touching the screen
  fingerCount = event.touches.length;
  // since we're looking for a swipe (single finger) and not a gesture (multiple fingers),
  // check that only one finger was used
  if ( fingerCount == 1 ) {
    // get the coordinates of the touch
    startX = event.touches[0].pageX;
    startY = event.touches[0].pageY;
    // store the triggering element ID
    triggerElementID = passedName;
  } else {
    // more than one finger touched so cancel
    touchCancel(event);
  }
}

function touchMove(event) {
  // if triggerElementID were null, then swiped-container has already been displayed
  if (triggerElementID) {
    curX = event.touches[0].pageX;
    curY = event.touches[0].pageY;
    deltaX = curX - startX;
    deltaY = curY - startY;
    if (isScrollingHorizontally === null) { // check once
      isScrollingHorizontally = !!( Math.abs(deltaX) > Math.abs(deltaY) );
    }
    if (isScrollingHorizontally) { // prevent vertical scrolling
      event.preventDefault();
      swipeLength = Math.round(Math.sqrt(Math.pow(curX - startX,2) + Math.pow(curY - startY,2)));
      if ( swipeLength >= minLength ) {
        processingRoutine();
        touchCancel(event);
      }
    }
  }
}

function touchEnd(event) {
  touchCancel(event)
}

function touchCancel(event) {
  // reset the variables back to default values
  triggerElementID = null;
  fingerCount = 0;
  startX = 0;
  startY = 0;
  curX = 0;
  curY = 0;
  deltaX = 0;
  deltaY = 0;
  swipeLength = 0;
  isScrollingHorizontally = null;
}

function processingRoutine() {
  var alreadyActive = $('#' + triggerElementID + '').hasClass('active');
  $('.swiped-container').removeClass('active');
  if (!alreadyActive) {
    // fadeIn is too expensive to render, this is a light weight substitute
    $('#' + triggerElementID + '').css('opacity', .93).addClass('active').delay(75).fadeTo(0, 1);
  }
}

// Click binding for desktop use
var deviceAgent = navigator.userAgent.toLowerCase();
var iOS = deviceAgent.match(/(iphone|ipod|ipad)/);
if (!iOS) {
  $('article').click(function() {
    triggerElementID = $(this).data('passed-name');
    processingRoutine();
    touchCancel();
  });
}