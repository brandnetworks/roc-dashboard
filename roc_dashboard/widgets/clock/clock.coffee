class Dashing.Clock extends Dashing.Widget

  ready: ->
    setInterval(@startTime, 500)

  startTime: =>
    today = new Date()
    h = today.getHours()
    if h > 12 then h-=12
    m = @formatTime(today.getMinutes())
    s = @formatTime(today.getSeconds())
    @set 'time', "#{h}:#{m}:#{s} #{@ampm()}"
    @set 'date', "#{@weekday()} #{today.getMonth()+1}.#{today.getDate()}.#{today.getFullYear()-2000}"


  weekday: () ->
    today = new Date()
    day = today.getDay()
    switch day
      when 0 then "sunday"
      when 1 then "monday"
      when 2 then "tuesday"
      when 3 then "wednesday"
      when 4 then "thursday"
      when 5 then "friday"
      when 6 then "saturday"

  ampm: () ->
    today = new Date()
    if today.getHours() >= 12 then "pm" else "am"

  formatTime: (i) ->
    if i < 10 then "0" + i else i
