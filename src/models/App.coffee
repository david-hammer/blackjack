# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @get('playerHand').on 'bust', (->
      @get('dealerHand').flipFirst()
      ), @

    @get('dealerHand').on 'bust', (->
      console.log 'dealer bust'
      ), @

  hit: ->
    @get('playerHand').hit()
  stand: ->
    if not @get('dealerHand').first().get('revealed')
      @get('dealerHand').stand()
