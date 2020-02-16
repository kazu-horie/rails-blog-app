require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe 'GET #index' do
    let!(:articles) do
      Array.new(2).map { create(:article, user_id: user.id) }
    end
    let(:user) { create(:user) }

    context '全件取得する場合' do
      before do
        login(user)

        get(:index)
      end

      it { expect(response).to have_http_status(:ok) }
    end

    context '全文検索で取得する場合' do
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

      before do
        login(user)

        Article.create_index!
        Article.__elasticsearch__.import(refresh: true)

        get(:index, params: { q: 'ホテル' })
      end

      it { expect(response).to have_http_status(:ok) }
    end
  end

  describe 'GET #new' do
    let(:user) { create(:user) }

    before do
      login(user)

      get(:new)
    end

    it { expect(response).to have_http_status(:ok)}
  end

  describe 'POST #CREATE' do
    let(:user) { create(:user) }

    before do
      login(user)

      post(
        :create,
        params: {
          article: {
            title: 'ホテルを買った',
            description: '大変高額でした。'
          }
        }
      )
    end

    it { expect(response).to redirect_to(article_url(Article.last)) }
  end

  describe 'GET #edit' do
    let(:article) { create(:article, user_id: user.id) }
    let(:user) { create(:user) }

    before do
      login(user)

      get(:edit, params: { id: article.id })
    end

    it { expect(response).to have_http_status(:ok) }
  end

  describe 'PATCH #update' do
    let(:article) { create(:article, user_id: user.id) }
    let(:user) { create(:user) }

    before do
      login(user)

      patch(:update,
        params: {
          id: article.id,
          article: {
            title: 'ホテルに泊まらなかった',
            description: '野宿はとても寒かった。'
          }
        }
      )
    end

    it { expect(response).to redirect_to(article_url(article)) }
  end

  describe 'DELETE #destroy' do
    let(:article) { create(:article, user_id: user.id) }
    let(:user) { create(:user) }

    before do
      login(user)

      delete(:destroy, params: { id: article.id })
    end

    it { expect(response).to redirect_to(articles_url) }
  end
end
