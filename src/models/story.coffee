class Ralio.Story extends Ralio.Model
  @_type: ['defect', 'hierarchicalrequirement']

class Ralio.StoryCollection extends Ralio.Collection
  model: Ralio.Story
  comparator: (story) -> story.get('Rank')

