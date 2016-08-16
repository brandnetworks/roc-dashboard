class Dashing.Scroll extends Dashing.Widget

  @accessor 'data1?', ->
    @get('scroll_info')['Bugs Created']

  @accessor 'data2?', ->
    @get('scroll_info')['Bugs Closed']

  @accessor 'data3?', ->
    @get('scroll_info')['Issues Opened']

  @accessor 'data4?', ->
    @get('scroll_info')['Issues Closed']

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
          wait = 250
          x = 0
        else if box3_location >= 900
          box3_location = -833
          box3.css "margin-left", box3_location
          box4_location = -400
          box4.css "margin-left", box4_location
          wait = 250
          x = 0
      # pause scrolling after movements
      else
        wait--
    , 50

  ready: ->
    @shift()
