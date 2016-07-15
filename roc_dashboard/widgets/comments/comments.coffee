class Dashing.Comments extends Dashing.Widget

  @accessor 'quote', ->
    "“#{@get('current_comment')?.body}”"

  @accessor 'tweets?', ->
    if @get('length') != 0
      @outer = $(@node).find('.outer')
      @outer.css 'background-image', "-webkit-linear-gradient( rgba(0, 0, 0, .55), rgba(0, 0, 0, .7), rgba(0, 0, 0, .7), rgba(0, 0, 0, .55))"
      ''
    else
      @outer = $(@node).find('.outer')
      @outer.css 'background-image', "rgba(0, 0, 0, 0)"
      'Closed'

  ready: ->
    @currentIndex = 0
    @commentElem = $(@node).find('.comment-container')
    @nextComment()
    @startCarousel()

  onData: (data) ->
    @currentIndex = 0

  startCarousel: ->
    setInterval(@nextComment, 20000)

  nextComment: =>
    comments = @get('comments')
    length = @get('length')
    if length > 1
      @commentElem.fadeOut =>
        @currentIndex = (@currentIndex + 1) % comments.length
        @set 'current_comment', comments[@currentIndex]
        $(@get('node')).css 'background-image', "url(#{@get('current_comment').avatar.replace /_normal/, ""})"
        @commentElem.fadeIn()
    else if length == 1
      @set 'current_comment', comments[@currentIndex]
      $(@get('node')).css 'background-image', "url(#{@get('current_comment').avatar.replace /_normal/, ""})"
      @commentElem.fadeIn()
    else
      $(@get('node')).css 'background-image', "url('assets/food-truck-blue.png')"
