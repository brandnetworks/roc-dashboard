class Dashing.Scroll extends Dashing.Widget

  names = []
  values = []
  current = 0

  setData: (pair) =>
    size = 0
    for key of @get('scroll_info')
      size++
    size
    if current >= size
      current = 0
    if pair == "first"
      @set 'data1', values[current]
      @set 'data2', values[current+1]
      @set 'name1', names[current]
      @set 'name2', names[current+1]
    else if pair == "second"
      @set 'data3', values[current]
      @set 'data4', values[current+1]
      @set 'name3', names[current]
      @set 'name4', names[current+1]
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

  onData: (data) ->
    @resetData()

  ready: ->
    @resetData()
    @setData "first"
    @setData "second"
    @shift()
