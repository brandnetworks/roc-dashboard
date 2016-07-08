class Dashing.Text extends Dashing.Widget

  @accessor 'title?', ->
    title = "#{@get('title')}".toUpperCase()

  @accessor 'artist?', ->
    artist = "#{@get('artist')}"

  @accessor 'album?', ->
    "#{@get('album')}"

  @accessor 'album_art?', ->
    url = @get('lastfm_art')
    if url == ""
      url = "assets/sonos-default-background.jpg"
    $(@get('node')).css 'background-image', "url(#{url})"
    "#{@get('album_art')}"
