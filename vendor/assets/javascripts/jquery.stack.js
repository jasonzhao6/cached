/*! jQuery.stack v1.0 by Jason Zhao | https://github.com/jasonzhao6 */
(function($) {
  $.fn.extend({
    stack: function() {
      var $parent = $(this),
          $children = $parent.children(),
          parentWidth,
          parentLeftPadding,
          childrenWidth,
          columnHeights,
          reset = function() {
            $parent.css({
              height: '',
              overflow: ''
            });
            $children.each(function(i, child){ 
              $(child).css({
                left: '',
                position: '',
                top: '',
                width: ''
              })
            });
            parentWidth = $parent.width();
            parentLeftPadding = parseInt($parent.css('padding-left'));
            childrenWidth = $children.outerWidth();
            columnHeights = new Array(Math.round(parentWidth / childrenWidth));
            $.each(columnHeights, function(i){
              columnHeights[i] = 0;
            });
          },
          nextShortestColumn = function() {
            index = 0;
            height = columnHeights[index];
            $.each(columnHeights, function(i){
              if (columnHeights[i] < height) {
                index = i;
                height = columnHeights[i];
              }
            });
            return index;
          },
          resizeAction = function() {
            reset();
            $children.each(function(i, child){ 
              $child = $(child)
              columnIndex = nextShortestColumn();
              columnHeight = columnHeights[columnIndex];
              columnHeights[columnIndex] += $child.height();
              $parent.css({
                height: Math.max.apply(null, columnHeights),
                overflow: 'hidden'
              });
              $child.css({
                left: childrenWidth * columnIndex + parentLeftPadding,
                position: 'absolute',
                top: columnHeight,
                width: childrenWidth
              })
            });
          };
      $(window).off('resize.stack').on('resize.stack', resizeAction).resize();
    }
  });
})(jQuery);