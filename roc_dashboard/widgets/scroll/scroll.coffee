class Dashing.Scroll extends Dashing.Widget

  names = []
  issues = []
  started = false

  @accessor 'name1?', ->
    "#{names[0]}"

  @accessor 'data1?', ->
    "#{issues[0]}"

  @accessor 'name2?', ->
    "#{names[1]}"

  @accessor 'data2?', ->
    "#{issues[1]}"

  @accessor 'name3?', ->
    "#{names[2]}"

  @accessor 'data3?', ->
    "#{issues[2]}"

  @accessor 'name4?', ->
    "#{names[3]}"

  @accessor 'data4?', ->
    "#{issues[3]}"

  shift: () ->
    # reset variables
    data1 = $(@get('node')).find('.data1')
    name1 = $(@get('node')).find('.name1')
    data2 = $(@get('node')).find('.data2')
    name2 = $(@get('node')).find('.name2')
    data3 = $(@get('node')).find('.data3')
    name3 = $(@get('node')).find('.name3')
    data4 = $(@get('node')).find('.data4')
    name4 = $(@get('node')).find('.name4')
    data1_location = 33
    data2_location = 466
    data3_location = -833
    data4_location = -400
    wait = 50
    x = 0
    @interval = setInterval ->
      # move text forward
      if x > 60 && x < 103
        val = 55
      else if x >= 60
        val = x-43
      else val = x
      dx = 9/(Math.exp(Math.pow(.045*val-2.718,2)))+1
      if wait == 0
        data1.css "margin-left", data1_location+=dx
        data2.css "margin-left", data2_location+=dx
        data3.css "margin-left", data3_location+=dx
        data4.css "margin-left", data4_location+=dx
        name1.css "margin-left", data1_location
        name2.css "margin-left", data2_location
        name3.css "margin-left", data3_location
        name4.css "margin-left", data4_location
        x+=1
        if data1_location >= 900
          data1_location = -833
          data1.css "margin-left", data1_location
          name1.css "margin-left", data1_location
          data2_location = -400
          data2.css "margin-left", data2_location
          name2.css "margin-left", data2_location
          wait = 50
          x = 0
        else if data3_location >= 900
          data3_location = -833
          data3.css "margin-left", data3_location
          name3.css "margin-left", data3_location
          data4_location = -400
          data4.css "margin-left", data4_location
          name4.css "margin-left", data4_location
          wait = 50
          x = 0
      # pause scrolling after movements
      else
        wait--
    , 50

  onData: (data) ->
    names = []
    issues = []
    scroll_info = @get('scroll_info')
    for key of scroll_info
      names.push key
      issues.push scroll_info[key]


  ready: ->
    @shift()
