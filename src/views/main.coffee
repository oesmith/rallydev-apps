class Ralio.MainView extends Backbone.View
  tagName: 'div'

  initialize: ->
    projects = new Ralio.ProjectCollection()
    @projectsView = new Ralio.ProjectsView(collection: projects)
    @$el.append(@projectsView.el)
    projects.fetch()
    @projectsView.on 'selected', (project, iteration) =>
      @iterationSelected(project, iteration)

  iterationSelected: (project, iteration) ->
    if @storiesView?
      @storiesView.$el.remove()
    source = new Ralio.DataSource(project.id)
    stories = new Ralio.StoryCollection(source: source)
    @storiesView = new Ralio.StoryListView(collection: stories)
    @$el.append(@storiesView.el)
    stories.fetch(query: "(Iteration = \"#{iteration._ref}\")")

