#
#

Ralio = Ember.Application.create()

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
    if typeof type == 'string'
      # single type
      opts =
        key: 'data'
        type: type.type
        fetch: true
        query: ''
      store.source.findAll(
        opts
        (object) -> store.loadMany(type, object.data)
        (err) -> console.log err
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
        (object) -> store.loadMany(type, object.data1.concat(object.data2))
        (err) -> console.log err
      )


Ralio.Project = DS.Model.extend()
Ralio.Project.reopenClass
  type: 'project'


Ralio.Story = DS.Model.extend()
Ralio.Project.reopenClass
  type: ['defect', 'hierarchicalrequirement']


Ralio.Iteration = DS.Model.extend()
Ralio.Project.reopenClass
  type: 'iteration'


rally.addOnLoad ->
  Ralio.store = DS.Store.create
    revision: 4
    adapter: Ralio.Adapter
    source: new rally.sdk.data.RallyDataSource(
      "__WORKSPACE_OID__",
      "__PROJECT_OID__",
      "__PROJECT_SCOPING_UP",
      "__PROJECT_SCOPING_DOWN__")
  window.projects = Ralio.store.findAll(Ralio.Project)


