class Dashing.Comments extends Dashing.Widget

  @accessor 'quote', ->
    "“#{@get('current_comment')?.body}”"

  @accessor 'tweets?', ->
    if @get('comments').length != 0
      ''
    else
      'No recent tweets from local food trucks'

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
    if comments.length != 0
      @commentElem.fadeOut =>
        @currentIndex = (@currentIndex + 1) % comments.length
        @set 'current_comment', comments[@currentIndex]
        $(@get('node')).css 'background-image', "url(#{@get('current_comment').avatar.replace /_normal/, ""})"
        @commentElem.fadeIn()
    else
      $(@get('node')).css 'background-image', "url(https://pbs.twimg.com/profile_images/666407537084796928/YBGgi9BO.png)"
