class window.Scoreboard extends Backbone.Model
  defaults:
      playerScore: 0
      dealerScore: 0
      message: ''
  initialize: ->
    console.log(@get('playerScore'))

  playerWon: ->
    @set('playerScore', @get('playerScore') + 1)
    @set('message', 'You won! :D')

  dealerWon: ->
    @set('dealerScore', @get('dealerScore') + 1)
    @set('message', 'You lost! :\'(')

  blackjackPush: ->
    @set('message', 'It was a tie :|')
