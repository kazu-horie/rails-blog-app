require 'rails_helper'

RSpec.describe ArticleSearchable, elasticsearch: true do
  describe '.search' do
    let!(:articles) do
      titles.map do |title|
        create(
          :article,
          user_id: user.id,
          title: title,
          description: 'ベッドがめちゃくちゃ大きかった。'
        )
      end
    end
    let(:titles) do
      [
        'ホテルに泊まった',
        'ホテルを建てた',
        '旅館に泊まった'
      ]
    end
    let(:user) { create(:user) }

    subject { Article.search(columns: [:title], keywords: 'ホテル').to_a }

    before do
      Article.create_index!
      Article.__elasticsearch__.import(refresh: true)
    end

    it { is_expected.to eq(Article.where("title LIKE '%ホテル%'").to_a) }
  end
end
