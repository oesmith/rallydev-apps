# Backbone.sync adapter for Rally dataSources

source = (model) ->
  if model.collection? and model.collection.source?
    model.collection.source
  else if model.source?
    model.source
  else
    throw 'no data source found'


type = (model) ->
  if model.model? and model.model.type?
    type = model.model.type
  else if model.type?
    type = model.type
  else
    throw 'no data type found'


findAll = (model, options) ->
  model_type = type(model)
  if typeof model_type == 'string'
    # single type
    opts =
      key: 'data'
      type: model_type
      fetch: true
      query: ''
    source(model).findAll(
      opts
      (object) -> options.success object.data
      options.error
    )
  else
    # dual types
    opts = [
      {
        key: 'data1'
        type: model_type[0]
        fetch: true
        query: ''
      },
      {
        key: 'data2'
        type: model_type[1]
        fetch: true
        query: ''
      }
    ]
    source(model).findAll(
      opts,
      (object) ->
        options.success object.data1.concat(object.data2)
      options.error
    )


find = (model, options) ->
  source(model).getRallyObject(
    model.id
    options.success
    options.error
  )


Ralio.sync = (method, model, options) ->
  switch method
    when 'create' then throw 'not implemented'
    when 'read'
      if model.id?
        find(model, options)
      else
        findAll(model, options)
    when 'update' then throw 'not implemented'
    when 'delete' then throw 'not implemented'

