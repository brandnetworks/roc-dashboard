class Dashing.Comments extends Dashing.Widget

  @accessor 'quote', ->
    "“#{@get('current_comment')?.body}”"

  @accessor 'date', ->
    date = "#{@get('current_comment.created_at')}".substr 0,10
    year = date.substr 0,4
    month = date.substr 5,2
    day = date.substr 8
    month + "/" + day + "/" + year

  ready: ->
    @currentIndex = 0
    @commentElem = $(@node).find('.comment-container')
    @nextComment()
    @startCarousel()

  onData: (data) ->
    @currentIndex = 0

  startCarousel: ->
    setInterval(@nextComment, 8000)

  nextComment: =>
    comments = @get('comments')
    if comments
      @commentElem.fadeOut =>
        @currentIndex = (@currentIndex + 1) % comments.length
        @set 'current_comment', comments[@currentIndex]
        $(@get('node')).css 'background-image', "url(#{@get('current_comment').avatar.replace /_normal/, ""})"
        @commentElem.fadeIn()
