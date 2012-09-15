require 'spec_helper'

describe Like do
  
  it { should belong_to(:story) }
  #it { should validate_uniqueness_of(:story_id).scoped_to(:user_id) }

end