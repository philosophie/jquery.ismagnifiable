$ ->
  
  $thumb = $('#thumb')
  $full = $('#magnified')
  
  thumbW = $thumb.width()
  thumbH = $thumb.height()
  fullW = parseInt $full.attr 'data-width'
  fullH = parseInt $full.attr 'data-height'
  glassW = $full.width()
  glassH = $full.height()
  
  # Get multiple of thumb dimensions to full dimensions
  xMult = fullW / thumbW
  yMult = fullH / thumbH
  
  $thumb.bind 'mousemove', (e) ->
    
    cursorX = e.layerX
    cursorY = e.layerY
    
    # determine bg position
    bgX = (cursorX * xMult) - (glassW / 2)
    bgY = (cursorY * yMult) - (glassH / 2)
    
    # offset bg
    $full.css
      backgroundPosition: "#{bgX * -1}px #{bgY * -1}px"
    
    # determine glass position
    glassX = cursorX - (glassW / 2)
    glassY = cursorY - (glassH / 2)
    
    # offset glass
    $full.css
      left: glassX,
      top: glassY
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    