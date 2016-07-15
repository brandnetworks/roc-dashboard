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

  fixSpace: (num) ->
    if num >= 0 then num else 0

  onData: (data)->
    # make the title, author, and album name scroll automatically
    # declarations
    box_width = 570
    title = $(@get('node')).find('.title')
    artist = $(@get('node')).find('.artist')
    album = $(@get('node')).find('.album')
    title_width = title.width()
    artist_width = artist.width()
    album_width = album.width()
    longest = Math.max.apply(Math, [title_width, artist_width, album_width])
    title_space = @fixSpace((title_width-box_width)/(longest/8))
    artist_space = @fixSpace((artist_width-box_width)/(longest/8))
    album_space = @fixSpace((album_width-box_width)/(longest/8))
    title_location = 0
    artist_location = 0
    album_location = 0
    forward = true
    wait = 50
    setInterval ->
      # move text forward
      if forward && wait == 0
        title.css "margin-left", title_location-=title_space
        artist.css "margin-left", artist_location-=artist_space
        album.css "margin-left", album_location-=album_space
        if title_location <= box_width-title_width and artist_location <= box_width-artist_width and album_location <= box_width-album_width
          forward = false
          wait = 50
      # move text back
      else if wait == 0
        title.css "margin-left", title_location+=title_space
        artist.css "margin-left", artist_location+=artist_space
        album.css "margin-left", album_location+=album_space
        if title_location >= 0 and artist_location >= 0 and album_location >= 0
          forward = true
          wait = 50
      # wait 2.5 seconds after movements
      else
        wait--
    , 50
