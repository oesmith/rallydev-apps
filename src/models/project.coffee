Ralio.Project = Backbone.Model.extend(
  {
    idAttribute: '_ref'
  }, {
    type: 'project'
  }
)

Ralio.ProjectCollection = Ralio.Collection.extend
  model: Ralio.Project
