class Dashing.Number extends Dashing.Widget

  color: () ->
    temp = @get('current')
    if temp > 100
      "#c2000b"
    else if temp > 85
      "#ff2717"
    else if temp > 70
      "#ffbe3d"
    else if temp > 55
      "#fefe51"
    else if temp > 40
      "#8ed162"
    else if temp > 25
      "#00cd9d"
    else if temp > 10
      "#00b2ec"
    else
      "#0073bc"

  @accessor 'current', Dashing.AnimatedValue

  @accessor 'increasing?', ->
    if @get('increasing') then 'fa fa-arrow-up' else 'fa fa-arrow-down'

  @accessor 'icon?', ->
    $(@get('node')).css 'background-color', @color()
    skycons = new Skycons({"color": "black"});
    skycons.add($(@get('node')).find('.forecast-icon').get(0), @get('icon'));
    skycons.play();

  onData: (data) ->
    if data.status
      # clear existing "status-*" classes
      $(@get('node')).attr 'class', (i,c) ->
        c.replace /\bstatus-\S+/g, ''
      # add new class
      $(@get('node')).addClass "status-#{data.status}"
