class Dashing.Text extends Dashing.Widget

  @accessor 'title?', ->
    "#{@get('title')}".toUpperCase()

  @accessor 'artist?', ->
    "#{@get('artist')}"

  @accessor 'album?', ->
    "#{@get('album')}"

  @accessor 'album_art?', ->
    $(@get('node')).css 'background-image', "url(#{@get('lastfm_art')})"
    "#{@get('album_art')}"
