Ralio.Project = DS.Model.extend
  primaryKey: '_ref'
  name: DS.attr 'string'
Ralio.Project.reopenClass
  type: 'project'

