$ = jQuery

$.fn.isMagnifiable = (set_options) ->
  
  # Default options
  defaults = {
    'glassWidth': 100,
    'glassHeight': 100
  };

  # Allow user to override default options
  options = $.extend({}, defaults, set_options);
  
  $(@).each ->
    
    $elem = $(@)

    fullImgSrc = $elem.attr 'href'

    $thumb = $elem.find('img')
    
    # get dimensions of thumb
    thumbW = $thumb.width()
    thumbH = $thumb.height()
    
    # wrap $elem in div
    $wrapper = $('<div class="ismagnifiable_wrapper">')
    $wrapper.css
      position: 'relative'
    $wrapper.width(thumbW).height(thumbH)
    $elem.wrap $wrapper
    
    # build a cover layer above the thumb
    $cover = $('<div class="ismagnifiable_cover">')
    $cover.css
      position: 'absolute'
      left: 0
      top: 0
      zIndex: 500
      backgroundColor: 'white'
      opacity: 0
    $cover.width(thumbW).height(thumbH)
    $elem.before $cover

    # Fetch full size image
    $fullImg = $('<img>')
    $fullImg.attr 'src', fullImgSrc
    
    $fullImg.load ->
  
      # insert fullImg into the DOM real quick to get dimensions
      $('body').append $fullImg
      fullW = $fullImg.width()
      fullH = $fullImg.height()
      $fullImg.remove()
  
      # change some css on $elem
      $elem.css
        position: 'absolute'
        top: 0
        left: 0
        zIndex: 1
        cursor: 'default'
        display: 'inline-block'
  
      $elem.click ->
        return false;
  
      # build magnifying glass div
      # and set img as background of magnifying glass div
      $full = $('<div>')
      $full.css
        borderRadius: '500px',
        border: '3px solid #000',
        width: options.glassWidth,
        height: options.glassHeight,
        overflow: 'hidden',
        boxShadow: 'rgba(0,0,0,0.5) 2px 2px 5px',
        background: "url(#{fullImgSrc}) no-repeat",
        position: 'absolute',
        top: 0,
        left: 0,
        zIndex: 2,
        pointerEvents: 'none'
  
      $full.hide()
  
      # prepend magnifying glass to $elem
      $elem.prepend $full

      # Get multiple of thumb dimensions to full dimensions
      xMult = fullW / thumbW
      yMult = fullH / thumbH

  
      $cover.bind 'mousemove', (e) ->
        
        cursorX = e.offsetX || e.layerX
        cursorY = e.offsetY || e.layerY

        # determine glass position
        glassX = cursorX - (options.glassWidth / 2)
        glassY = cursorY - (options.glassHeight / 2)

        # offset glass
        $full.css
          left: glassX,
          top: glassY
    
        # determine bg position
        bgX = (cursorX * xMult) - (options.glassWidth / 2)
        bgY = (cursorY * yMult) - (options.glassHeight / 2)
  
        # offset bg
        $full.css
          backgroundPosition: "#{bgX * -1}px #{bgY * -1}px"


      # show glass on mouseover
      $cover.bind 'mouseover', (e) ->
        $full.fadeIn 500

      # hide glass on mouseout
      $cover.bind 'mouseout', (e) ->
        $full.fadeOut 200
  

    
    
    
    
    
    
    
    
