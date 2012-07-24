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
    opts =
      key: 'data'
      type: type.type
      fetch: true
      query: ''
    store.source.findAll(
      opts
      (object) ->
        store.loadMany(type, object.data)
      (err) ->
        console.log err
    )


Ralio.Project = DS.Model.extend()
Ralio.Project.reopenClass
  type: 'project'


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


