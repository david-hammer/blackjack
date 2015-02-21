class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    if @isDealer
      if @minScore() > 21
        @bust()
      else if (@minScore() < 17 && (@scores()[1] <= 17 || @scores()[1] >= 22))
        @add(@deck.pop())
        @hit()
      else #game over - need to check scores
        @gameOver()
    else
      if @minScore() <= 21
        @add(@deck.pop())
        if @minScore() > 21
          @bust()

  stand: ->
    if @isDealer
      @flipFirst()
      @hit()
    else
      @first().flip()

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  flipFirst: ->
    @first().flip()

  bust: ->
    console.log('bust event triggered')
    @trigger('bust', @)

  gameOver: ->
    console.log('gameover')
    @trigger('gameOver', @)

