require 'rails_helper'

RSpec.describe ArticleSearchable, elasticsearch: true do
  describe '.search' do
    let!(:articles) do
      titles.map do |title|
        create(
          :article,
          user_id: user.id,
          title: title
        )
      end
    end
    let(:titles) do
      [
        'ホテルに泊まった',
        '学校を建てた',
        'プログラミングを勉強した'
      ]
    end
    let(:user) { create(:user) }

    subject { Article.search(columns: [:title], keywords: 'ホテル').to_a }

    before do
      Article.create_index!
      Article.__elasticsearch__.import(refresh: true)
    end

    it { is_expected.to eq(Article.where("title LIKE '%ホテル%'").to_a) }

    context '類義語が存在する場合' do
      let(:titles) do
        [
          'ホテルに泊まった',
          '旅館を建てた',
          'プログラミングを勉強した'
        ]
      end

      subject { Article.search(columns: [:title], keywords: 'ホテル').to_a }

      before do
        Article.create_index!
        Article.__elasticsearch__.import(refresh: true)
      end

      it do
        is_expected.to eq(
          Article.where("title LIKE '%ホテル%'")
            .or(Article.where("title LIKE '%旅館%'"))
            .to_a
          )
      end
    end
  end
end
