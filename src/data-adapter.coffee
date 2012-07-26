object_decamelize = (obj) ->
  ret = {}
  for key, val of obj
    ret[Ember.String.decamelize(key)] = val
  ret

Ralio.Adapter = DS.Adapter.create

  find: (store, type, id) ->
    store.source.getRallyObject(
      id
      (object) ->
        store.load object
      (response) ->
        console.log response
    )

  findAll: (store, type) ->
    if typeof type.type == 'string'
      # single type
      opts =
        key: 'data'
        type: type.type
        fetch: true
        query: ''
      store.source.findAll(
        opts
        (object) ->
          data = (object_decamelize(o) for o in object.data)
          store.loadMany(type, data)
        (err) ->
          console.log err
      )
    else
      # dual types
      opts = [
        {
          key: 'data1'
          type: type.type[0]
          fetch: true
          query: ''
        },
        {
          key: 'data2'
          type: type.type[1]
          fetch: true
          query: ''
        }
      ]
      store.source.findAll(
        opts,
        (object) ->
          data = (object_decamelize(o) for o in object.data1.concat(object.data2))
          store.loadMany(type, data)
        (err) -> console.log err
      )
