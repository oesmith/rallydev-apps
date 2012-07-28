Ralio.ProjectsView = Backbone.View.extend
  tagName: 'div'
  initialize: ->
    @collection.bind 'add remove change reset', => @changed()
    @changed()
  changed: ->
    console.log('changed')
    if @timeout_id then clearTimeout(@timeout_id)
    @timeout_id = setTimeout(
      => @changeTimeout()
      20)
  changeTimeout: ->
    @timeout_id = null
    @render()
  render: ->
    names = @collection.map (project) -> project.get('Name')
    console.log names
    @$el.html names.join('<br>')

