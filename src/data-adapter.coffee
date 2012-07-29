# Backbone.sync adapter for Rally dataSources

source = (model) ->
  if model.collection? and model.collection.source?
    model.collection.source
  else if model.source?
    model.source
  else
    throw 'no data source found'


findAll = (model, options) ->
  types = model.type()
  if _(types).isString() then types = [types]
  query = _(types).map (t) ->
    _({}).extend(
      { query: '', fetch: true, type: t, key: t }
      _(options).pick('query', 'fetch', 'project')
    )
  source(model).findAll(
    query
    (o) ->
      console.log o
      options.success _.chain(o).pick(types).values().flatten().value()
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

