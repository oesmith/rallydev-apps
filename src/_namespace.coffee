Ralio = {}

Ralio.Collection = Backbone.Collection.extend
  initialize: (models, options) ->
    if options.source? then @source = options.source
