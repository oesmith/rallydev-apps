
rally.addOnLoad ->

  Ralio.store = DS.Store.create
    revision: 4
    adapter: Ralio.Adapter
    source: new rally.sdk.data.RallyDataSource(
      "__WORKSPACE_OID__",
      "__PROJECT_OID__",
      "__PROJECT_SCOPING_UP",
      "__PROJECT_SCOPING_DOWN__")

  Ralio.projectController = Ember.ArrayController.create
    content: Ralio.store.findAll(Ralio.Project)

  view = Ralio.ProjectsView.create()
  view.appendTo('#main')

