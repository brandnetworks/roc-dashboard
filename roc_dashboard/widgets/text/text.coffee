class Dashing.Text extends Dashing.Widget

  @accessor 'title?', ->
    title = "#{@get('title')}".toUpperCase() + " EXTRA TEXT FOR LENGTH"

  @accessor 'artist?', ->
    artist = "#{@get('artist')}"

  @accessor 'album?', ->
    "#{@get('album')}"

  @accessor 'album_art?', ->
    $(@get('node')).css 'background-image', "url(assets/sonos-default-background.jpg)"
    url = @get('lastfm_art')
    if url != "" && url != "https://secure-img2.last.fm/i/u/c1cd8e1f59364c6fbd177cf16f70039c.png"
      $(@get('node')).css 'background-image', "url(#{url})"
    "#{@get('album_art')}"

  @accessor 'shift?', ->
    box_width = 570
    title = $(@get('node')).find('.title')
    title_width = title.width()
    space = 0
    #if title_width > box_width && space > -100
    #setInterval ->
    #    title.css 'margin-left', space--
    #  , 10
    #""
