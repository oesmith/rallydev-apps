class Ralio.StoryListView extends Backbone.View
  tagName: 'div'
  template: Handlebars.templates['story-list']

  events: {}

  initialize: ->
    @collection.bind 'reset', => @render()

  render: ->
    stories = @collection.map (story) -> story.toJSON()
    console.log stories
    @$el.html @template(stories: stories)

