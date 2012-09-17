/*! jQuery.stack v1.0 by Jason Zhao | https://github.com/jasonzhao6 */
(function($) {
  $.fn.extend({
    stack: function() {
      var $parent = $(this),
          parentWidth = $parent.width() + $parent.width() % 2,
          parentLeftPadding = parseInt($parent.css('padding-left'))
          $children = $parent.children(),
          childrenWidth = $children.outerWidth(),
          numColumns = Math.floor(parentWidth / childrenWidth),
          columnHeights = new Array(numColumns),
          initialize = function() {
            resetcolumnHeights();
            $children.each(function(i, child){ 
              $child = $(child)
              columnIndex = nextShortestColumn();
              $child.css({
                left: childrenWidth * columnIndex + parentLeftPadding,
                position: 'absolute',
                top: columnHeights[columnIndex],
                width: childrenWidth
              })
              columnHeights[columnIndex] += $child.height();
            });
            $parent.height(Math.max.apply(null, columnHeights));
          },
          resetcolumnHeights = function() {
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
          };
      initialize();
    }
  });
})(jQuery);