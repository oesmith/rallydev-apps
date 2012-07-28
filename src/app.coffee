
rally.addOnLoad ->

  source = new rally.sdk.data.RallyDataSource(
    "__WORKSPACE_OID__",
    "__PROJECT_OID__",
    "__PROJECT_SCOPING_UP",
    "__PROJECT_SCOPING_DOWN__")

  Backbone.sync = Ralio.sync

  projects = new Ralio.ProjectCollection [],
    source: source

  view = new Ralio.ProjectsView
    collection: projects

  $('#main').append(view.el)

  projects.fetch()


  #
  #  Ralio.projectController = Ember.ArrayController.create
  #    content: Ralio.store.findAll(Ralio.Project)
  #
  #  view = Ralio.ProjectsView.create()
  #  view.appendTo('#main')

