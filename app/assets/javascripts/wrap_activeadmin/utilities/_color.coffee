@hexToRgba = (hex, opacity) ->
  #extract the two hexadecimal digits for each color
  patt = /^#([\da-fA-F]{2})([\da-fA-F]{2})([\da-fA-F]{2})$/
  matches = patt.exec(hex)
  #convert them to decimal
  r = parseInt(matches[1], 16)
  g = parseInt(matches[2], 16)
  b = parseInt(matches[3], 16)
  #create rgba string
  rgba = 'rgba(' + r + ',' + g + ',' + b + ',' + opacity + ')'
  #return rgba colour
  rgba
