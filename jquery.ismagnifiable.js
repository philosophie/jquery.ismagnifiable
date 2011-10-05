(function() {
  var $;
  $ = jQuery;
  $.fn.isMagnifiable = function(set_options) {
    var defaults, options;
    defaults = {
      'glassWidth': 100,
      'glassHeight': 100
    };
    options = $.extend({}, defaults, set_options);
    return $(this).each(function() {
      var $elem, $fullImg, $thumb, fullImgSrc;
      $elem = $(this);
      fullImgSrc = $elem.attr('href');
      $thumb = $elem.find('img');
      $fullImg = $('<img>');
      $fullImg.attr('src', fullImgSrc);
      return $fullImg.load(function() {
        var $full, fullH, fullW, thumbH, thumbW, xMult, yMult;
        $('body').append($fullImg);
        fullW = $fullImg.width();
        fullH = $fullImg.height();
        $fullImg.remove();
        thumbW = $thumb.width();
        thumbH = $thumb.height();
        $elem.css({
          position: 'relative',
          zIndex: 1,
          cursor: 'default',
          display: 'inline-block'
        });
        $elem.click(function() {
          return false;
        });
        $full = $('<div>');
        $full.css({
          borderRadius: '500px',
          border: '3px solid #000',
          width: options.glassWidth,
          height: options.glassHeight,
          overflow: 'hidden',
          boxShadow: 'rgba(0,0,0,0.5) 2px 2px 5px',
          background: "url(" + fullImgSrc + ") no-repeat",
          position: 'absolute',
          top: 0,
          left: 0,
          zIndex: 2,
          pointerEvents: 'none'
        });
        $full.hide();
        $elem.prepend($full);
        console.log('fullImg', $fullImg, $fullImg.width(), $fullImg.height());
        console.log('thumb', $thumb.width(), $thumb.height());
        console.log('full', $full.width(), $full.height());
        xMult = fullW / thumbW;
        yMult = fullH / thumbH;
        $thumb.bind('mousemove', function(e) {
          var bgX, bgY, cursorX, cursorY, glassX, glassY;
          cursorX = e.layerX;
          cursorY = e.layerY;
          glassX = cursorX - (options.glassWidth / 2);
          glassY = cursorY - (options.glassHeight / 2);
          $full.css({
            left: glassX,
            top: glassY
          });
          bgX = (cursorX * xMult) - (options.glassWidth / 2);
          bgY = (cursorY * yMult) - (options.glassHeight / 2);
          return $full.css({
            backgroundPosition: "" + (bgX * -1) + "px " + (bgY * -1) + "px"
          });
        });
        $thumb.bind('mouseover', function(e) {
          console.log('mouseover');
          return $full.fadeIn();
        });
        return $thumb.bind('mouseout', function(e) {
          console.log('mouseout');
          return $full.fadeOut();
        });
      });
    });
  };
}).call(this);
