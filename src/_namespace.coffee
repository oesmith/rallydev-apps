Ralio = {}

class Ralio.DataSource
  constructor: (project) ->
    @ds = new rally.sdk.data.RallyDataSource(
      "__WORKSPACE_OID__",
      if project? then project else "__PROJECT_OID__",
      "__PROJECT_SCOPING_UP",
      "__PROJECT_SCOPING_DOWN__")

  find: (model, options) ->
    @ds.getRallyObject(model.id, options.success, options.error)

  findAll: (model, options) ->
    types = model.type()
    query = _(types).map (t) ->
      _({}).extend(
        { query: '', fetch: true, type: t, key: t }
        _(options).pick('query', 'fetch', 'project')
      )
    @ds.findAll(
      query,
      (o) ->
        console.log o
        options.success _.chain(o).pick(types).values().flatten().value()
      options.error
    )

  sync: (method, model, options) ->
    switch method
      when 'create' then throw 'not implemented'
      when 'read'
        if model.id?
          @find(model, options)
        else
          @findAll(model, options)
      when 'update' then throw 'not implemented'
      when 'delete' then throw 'not implemented'


class Ralio.Model extends Backbone.Model
  idAttribute: '_ref'

  sync: (method, model, options) ->
    @collection.source.sync(method, model, options)

  @type: ->
    if _(@_type).isString() then [@_type] else @_type


class Ralio.Collection extends Backbone.Collection
  initialize: (models, options) ->
    if options?.source?
      @source = options.source
    else
      @source = new Ralio.DataSource()

  type: ->
    @model.type()

  sync: (method, model, options) ->
    @source.sync(method, model, options)

