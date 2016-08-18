class Dashing.Scroll extends Dashing.Widget

  names = []
  values = []
  current = 0
  previous = 0

  resizeText: (box1, box2) ->
    if isNaN values[current] then size = "60px" else size = "100px"
    $(@get('node')).find(".#{box1} .data").css "font-size", size
    if isNaN values[current+1] then size = "60px" else size = "100px"
    $(@get('node')).find(".#{box2} .data").css "font-size", size

  setData: (pair) ->
    if current >= names.length
      current = 0
    # remove number from Product Blocker display
    names1 = names[current]
    names2 = names[current+1]
    if (names1 && names1.indexOf "Product") > 0
      names1 = names1.substring 2,17
    if (names2 && names2.indexOf "Product") > 0
      names2 = names2.substring 2,17
    # set data for first two boxes
    if pair == "first"
      @set 'data1', values[current]
      @set 'data2', values[current+1]
      @set 'name1', names1
      @set 'name2', names2
      # reduce size of text if not a number, reset otherwise
      @resizeText('box1', 'box2')
    # set data for second two boxes
    else if pair == "second"
      @set 'data3', values[current]
      @set 'data4', values[current+1]
      @set 'name3', names1
      @set 'name4', names2
      # reduce size of text if not a number, reser otherwise
      @resizeText('box3', 'box4')
    current +=2

  shift: () ->
    # reset variables
    box1 = $(@get('node')).find('.box1')
    box2 = $(@get('node')).find('.box2')
    box3 = $(@get('node')).find('.box3')
    box4 = $(@get('node')).find('.box4')
    box1_location = 33
    box2_location = 466
    box3_location = -833
    box4_location = -400
    wait = 50
    x = 5
    self = this
    @interval = setInterval ->
      # move text forward
      if x > 60 && x < 104
        val = 55
      else if x >= 104
        val = x-44
      else val = x
      # calculate the distance the boxes must move
      dx = 9/(Math.exp(Math.pow(.045*val-2.718,2)))+1
      if wait == 0
        box1.css "margin-left", box1_location+=dx
        box2.css "margin-left", box2_location+=dx
        box3.css "margin-left", box3_location+=dx
        box4.css "margin-left", box4_location+=dx
        x+=1
        if box1_location >= 900
          box1_location = -833
          box1.css "margin-left", box1_location
          box2_location = -400
          box2.css "margin-left", box2_location
          wait = 50
          x = 0
          self.setData "first"
        else if box3_location >= 900
          box3_location = -833
          box3.css "margin-left", box3_location
          box4_location = -400
          box4.css "margin-left", box4_location
          wait = 50
          x = 0
          self.setData "second"
      # pause scrolling after movements
      else
        wait--
    , 50

  resetData: () ->
    names = []
    values = []
    scroll_info = @get('scroll_info')
    for key of scroll_info
      names.push key
      values.push scroll_info[key]
    # remove last item if uneven amount of items
    size = names.length
    if size % 2 != 0
      names.splice names.length-1, 1
      values.splice values.length-1, 1
      size -=1
    if current >= size
      current = 0

  onData: (data) ->
    @resetData()
    if names.length > 2 && previous <= 2
      previous = names.length
      @shift()
    else if names.length <= 2 && previous > 2
      previous = names.length
      clearInterval() @interval

  ready: ->
    @resetData()
    @setData "first"
    @setData "second"
    if names.length > 2
      @shift()
