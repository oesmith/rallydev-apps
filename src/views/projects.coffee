Ralio.ProjectsView = Backbone.View.extend
  tagName: 'div'
  template: Handlebars.templates['projects']

  events: {
    'change .project-selector': 'onProjectSelected',
    'change .iteration-selector': 'onIterationSelected'
  }

  initialize: ->
    @collection.bind 'reset', => @render()
    @render()

  render: ->
    projects = @collection.map (project) -> project.toJSON()
    iterations = if @project? then @project.get('Iterations')
    @$el.html @template(projects: projects, project: @project, iterations: iterations)
    if @project? then $('.project-selector').val(@project.id)
    if @iteration? then $('.iteration-selector').val(@iteration._ref)

  onProjectSelected: ->
    id = $('.project-selector').val()
    @project = if id then @collection.get(id) else null
    @iteration = null
    @render()

  onIterationSelected: ->
    id = $('.iteration-selector').val()
    @iteration = if id then _.find(@project.get('Iterations'), (i) -> i._ref == id) else null
    @render()
    if @iteration? then @trigger 'selected', @project, @iteration
      # @stories = new Ralio.StoryCollection [], source: @collection.source
      # @stories.fetch(query: "(Iteration = \"#{@iteration._ref}\")")
      # @stories.on 'reset', => console.log @stories
