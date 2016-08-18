class Dashing.Comments extends Dashing.Widget

  @accessor 'quote', ->
    # remove whitespace and add quotes
    comment = "#{@get('current_comment')?.body}".trim()
    "\"#{comment}\""

  @accessor 'tweets?', ->
    if @get('length') != 0
      ''
    else
      'Closed'

  ready: ->
    @truckNum = 2
    @currentIndex = 0
    @commentElem = $(@node).find('.comment-container')
    @nextComment()
    @startCarousel()

  onData: (data) ->
    @currentIndex = 0
    @commentElem = $(@node).find('.comment-container')
    @nextComment()

  startCarousel: ->
    setInterval(@nextComment, 20000)

  addGradient: (add) ->
    outer = $(@node).find('.outer')
    if add
      outer.css 'background-image', "-webkit-linear-gradient( rgba(0, 0, 0, .55), rgba(0, 0, 0, .7), rgba(0, 0, 0, .7), rgba(0, 0, 0, .55))"
    else
      outer.css 'background-image', "-webkit-linear-gradient( rgba(0, 0, 0, 0), rgba(0, 0, 0, 0))"

  nextComment: =>
    @comments = @get('comments')
    length = @get('length')
    if length > 1
      # rotate between multiple tweets
      @addGradient true
      @truckNum = if @truckNum == 1 then 2 else 1
      @set 'trucks', "#{@truckNum}/2"
      @commentElem.fadeOut =>
        @currentIndex = (@currentIndex + 1) % @comments.length
        @set 'current_comment', @comments[@currentIndex]
        $(@get('node')).css 'background-image', "url(#{@get('current_comment').avatar.replace /_normal/, ""})"
        @commentElem.fadeIn()
    else if length == 1
      # display only one tweet
      @set 'trucks', "1/1"
      @addGradient true
      @set 'current_comment', @comments[@currentIndex]
      $(@get('node')).css 'background-image', "url(#{@get('current_comment').avatar.replace /_normal/, ""})"
      @commentElem.fadeIn()
    else
      # display "no food trucks" screen
      @addGradient false
      @commentElem.fadeOut =>
        $(@get('node')).css 'background-image', "url('assets/food-truck.png')"
