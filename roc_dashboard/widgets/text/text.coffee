class Dashing.Text extends Dashing.Widget
  @accessor 'title?', ->
    "#{@get('title')}".toUpperCase()

  @accessor 'artist?', ->
    "#{@get('artist')}"

  @accessor 'album?', ->
    "#{@get('album')}"

  @accessor 'album_art?', ->
    "#{@get('album_art')}".substring(22)
