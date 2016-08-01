class Dashing.Comments extends Dashing.Widget

  @accessor 'quote', ->
    comment = "#{@get('current_comment')?.body}".trim()
    "\"#{comment}\""

  @accessor 'tweets?', ->
    if @get('length') != 0
      ''
    else
      'Closed'

  ready: ->
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

  nextComment: =>
    @comments = @get('comments')
    length = @get('length')
    if length > 1
      @outer = $(@node).find('.outer')
      @outer.css 'background-image', "-webkit-linear-gradient( rgba(0, 0, 0, .55), rgba(0, 0, 0, .7), rgba(0, 0, 0, .7), rgba(0, 0, 0, .55))"
      @commentElem.fadeOut =>
        @currentIndex = (@currentIndex + 1) % @comments.length
        @set 'current_comment', @comments[@currentIndex]
        $(@get('node')).css 'background-image', "url(#{@get('current_comment').avatar.replace /_normal/, ""})"
        @commentElem.fadeIn()
    else if length == 1
      @outer = $(@node).find('.outer')
      @outer.css 'background-image', "-webkit-linear-gradient( rgba(0, 0, 0, .55), rgba(0, 0, 0, .7), rgba(0, 0, 0, .7), rgba(0, 0, 0, .55))"
      @set 'current_comment', @comments[@currentIndex]
      $(@get('node')).css 'background-image', "url(#{@get('current_comment').avatar.replace /_normal/, ""})"
      @commentElem.fadeIn()
    else
      @outer = $(@node).find('.outer')
      @outer.css 'background-image', "-webkit-linear-gradient( rgba(0, 0, 0, 0), rgba(0, 0, 0, 0))"
      @commentElem.fadeOut =>
        $(@get('node')).css 'background-image', "url('assets/food-truck.png')"
