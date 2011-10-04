(function() {
  $(function() {
    var $full, $thumb, fullH, fullW, glassH, glassW, thumbH, thumbW, xMult, yMult;
    $thumb = $('#thumb');
    $full = $('#magnified');
    thumbW = $thumb.width();
    thumbH = $thumb.height();
    fullW = parseInt($full.attr('data-width'));
    fullH = parseInt($full.attr('data-height'));
    glassW = $full.width();
    glassH = $full.height();
    xMult = fullW / thumbW;
    yMult = fullH / thumbH;
    return $thumb.bind('mousemove', function(e) {
      var bgX, bgY, cursorX, cursorY, glassX, glassY;
      cursorX = e.layerX;
      cursorY = e.layerY;
      bgX = (cursorX * xMult) - (glassW / 2);
      bgY = (cursorY * yMult) - (glassH / 2);
      $full.css({
        backgroundPosition: "" + (bgX * -1) + "px " + (bgY * -1) + "px"
      });
      glassX = cursorX - (glassW / 2);
      glassY = cursorY - (glassH / 2);
      return $full.css({
        left: glassX,
        top: glassY
      });
    });
  });
}).call(this);
