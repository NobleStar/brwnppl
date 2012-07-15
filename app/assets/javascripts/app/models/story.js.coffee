class App.StoryModel extends Spine.Model
  @configure 'Story', 'title', 'description', 'url'
  @extend Spine.Model.Ajax

  @url = '/api/stories'