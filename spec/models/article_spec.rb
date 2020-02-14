require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user_id) }

    it { should validate_presence_of(:title) }

    it { should validate_presence_of(:description) }
  end

  describe '.search_by_title' do
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

    subject { Article.search_by_title('ホテル').to_a }

    before do
      # FIXME: 手動で FullText Index を作成しないとインデックスが使えない
      ActiveRecord::Base.connection.execute 'ALTER TABLE articles DROP INDEX index_articles_on_title;'
      @index_key = "index_documents_on_tags_#{Time.current.to_i}"
      ActiveRecord::Base.connection.execute "CREATE FULLTEXT INDEX #{@index_key} ON articles (title) WITH PARSER ngram;"
    end

    after do
      # FIXME
      ActiveRecord::Base.connection.execute "ALTER TABLE articles DROP INDEX #{@index_key};"
      ActiveRecord::Base.connection.execute 'CREATE FULLTEXT INDEX index_articles_on_title ON articles (title) WITH PARSER ngram;'
    end

    it do
      is_expected.to eq(Article.where("title LIKE '%ホテル%'").to_a)
    end
  end
end
