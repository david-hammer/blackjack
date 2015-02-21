class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img class="card" src="img/cards/<%= rankName %>_of_<%= suitName %>.png" />'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'


