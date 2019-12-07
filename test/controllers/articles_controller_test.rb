require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)

    @auth_headers = { Authorization:
      ActionController::HttpAuthentication::Basic
      .encode_credentials(ENV['USER_NAME'], ENV['PASSWORD']) }
  end

  test "should get index" do
    get(articles_url, headers: @auth_headers)

    assert_response :success
  end

  test "should get new" do
    get(new_article_url, headers: @auth_headers)

    assert_response :success
  end

  test "should create article" do
    assert_difference('Article.count') do
      article_params = {
        user_name: @article.user.name,
        title: 'test',
        description: 'testtesttest'
      }
      post(
        articles_url,
        params: { article: article_params },
        headers: @auth_headers
      )
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should show article" do
    get(article_url(@article), headers: @auth_headers)

    assert_response :success
  end

  test "should get edit" do
    get(edit_article_url(@article), headers: @auth_headers)

    assert_response :success
  end

  test "should update article" do
    patch(
      article_url(@article),
      headers: @auth_headers,
      params: { article: { title: 'test2', user_name: @article.user.name } }
    )

    assert_redirected_to article_url(@article)
  end

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete(article_url(@article), headers: @auth_headers)
    end

    assert_redirected_to articles_url
  end
end
