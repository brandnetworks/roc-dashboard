class Dashing.Text extends Dashing.Widget

  @accessor 'title?', ->
    "#{@get('title')}".toUpperCase()

  @accessor 'artist?', ->
    "#{@get('artist')}"

  @accessor 'album?', ->
    "#{@get('album')}"

  @accessor 'album_art?', ->
    if @get('music')
      # align items and set background
      $(@get('node')).find('.album-art').css 'display', 'inline'
      $(@get('node')).find('.title-box').css 'margin-top', '169px'
      $(@get('node')).css 'background-image', "url(assets/sonos-default-background.jpg)"
      url = @get('lastfm_art')
      if url != "" && url.substring(0,18) != "https://secure-img"
        $(@get('node')).css 'background-image', "url(#{url})"
      # determine if there is an album art image
      if "#{@get('album_art')}" != ""
        "#{@get('album_art')}"
      else
        "/assets/default-album-art.png"
    else
      # align items when no music is playing
      $(@get('node')).css 'background-image', "url(assets/sonos-default-background.jpg)"
      $(@get('node')).find('.album-art').css 'display', 'none'
      $(@get('node')).find('.title-box').css 'margin-top', '220px'
      ""

  fixSpace: (num) ->
    if num >= 0 then num else 0

  shift: () ->
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
    wait = 150
    @interval = setInterval ->
      # move text forward
      if forward && wait == 0
        title.css "margin-left", title_location-=title_space
        artist.css "margin-left", artist_location-=artist_space
        album.css "margin-left", album_location-=album_space
        if title_location <= box_width-title_width && artist_location <= box_width-artist_width && album_location <= box_width-album_width
          forward = false
          wait = 50
      # move text back
      else if wait == 0
        title.css "margin-left", title_location+=title_space
        artist.css "margin-left", artist_location+=artist_space
        album.css "margin-left", album_location+=album_space
        if title_location >= 0 && artist_location >= 0 && album_location >= 0
          forward = true
          wait = 150
      # pause scrolling after movements
      else
        wait--
    , 50

  onData: (data) ->
    # reset scrolling
    $(@get('node')).find('.title').css "margin-left", 0
    $(@get('node')).find('.artist').css "margin-left", 0
    $(@get('node')).find('.album').css "margin-left", 0
    clearInterval @interval
    if @get('music')
      @shift()
