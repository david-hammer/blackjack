# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'scoreboard', scoreboard = new Scoreboard()

    @get('playerHand').on 'bust', (->
      @get('dealerHand').flipFirst()
      scoreboard.dealerWon()
      ), @

    @get('dealerHand').on 'bust', (->
      scoreboard.playerWon()
      ), @

    @get('dealerHand').on 'gameOver', (->
      playerScore = @get('playerHand').scores()
      dealerScore = @get('dealerHand').scores()

      finalPlayerScore = if (playerScore[1] < 22) then playerScore[1] else playerScore[0]
      finalDealerScore = if (dealerScore[1] < 22) then dealerScore[1] else dealerScore[0]

      if finalPlayerScore > finalDealerScore
        scoreboard.playerWon()

      else if finalDealerScore > finalPlayerScore
        scoreboard.dealerWon()

      else
        scoreboard.blackjackPush()
      ), @


  hit: ->
    @get('playerHand').hit()
  stand: ->
    if not @get('dealerHand').first().get('revealed')
      @get('dealerHand').stand()
