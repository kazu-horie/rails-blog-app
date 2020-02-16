require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_id) }

    it { should validate_presence_of(:title) }

    it { should validate_presence_of(:description) }
  end
end
