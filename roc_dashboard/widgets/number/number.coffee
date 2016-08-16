class Dashing.Number extends Dashing.Widget

  color: () ->
    temp = @get('current')
    if temp > 80
      "#FF901D"
    else if temp > 65
      "#FFDF3A"
    else if temp > 50
      "#ACF371"
    else if temp > 30
      "#BBFFFF"
    else
      "#73CEFF"

  @accessor 'increasing?', ->
    if @get('increasing') then 'fa fa-arrow-up' else 'fa fa-arrow-down'

  @accessor 'icon?', ->
    $(@get('node')).css 'background-color', @color()
    skycons = new Skycons({"color": "black"})
    skycons.add($(@get('node')).find('.forecast-icon').get(0), @get('icon'))
    skycons.play()

  @accessor 'summary?', ->
    check = false
    summary = @get('summary')
    if summary
      wordList = ["rain", "snow", "hail", "sleet", "thunder", "storm"]
      check = wordList.some (word) -> ~summary.toLowerCase().indexOf word
    if !check
      summary = ""
    summary

  onData: (data) ->
    if data.status
      # clear existing "status-*" classes
      $(@get('node')).attr 'class', (i,c) ->
        c.replace /\bstatus-\S+/g, ''
      # add new class
      $(@get('node')).addClass "status-#{data.status}"
