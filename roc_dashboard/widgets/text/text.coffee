class Dashing.Text extends Dashing.Widget

  @accessor 'title?', ->
    title = "#{@get('title')}".toUpperCase()

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
