class Dashing.Number extends Dashing.Widget

  color: () ->
    temp = @get('current')
    if temp > 85
      "#FA6900"
    else if temp > 65
      "#F38630"
    else if temp > 50
      "#E0E4CC"
    else if temp > 30
      "#A7DBD8"
    else
      "#69D2E7"

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
