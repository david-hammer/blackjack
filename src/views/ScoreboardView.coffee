class window.ScoreboardView extends Backbone.View
  className: 'scoreboard'

  template: _.template '<table><thead><tr><th>Player Score</th><th>Dealer Score</th></tr></thead><tbody><tr><td><%= playerScore %></td><td><%= dealerScore %></td></tr></tbody></table>'

  initialize: ->
    @model.on 'change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.append(@model.get('message'))


