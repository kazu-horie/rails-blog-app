require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "should not save article without user_id" do
    article = Article.new(
      title: 'test',
      description: 'testtesttesttesttest'
    )

    assert_not article.save
  end

  test "should not save article without title" do
    article = Article.new(
      user_id: 1,
      title: 'test'
    )

    assert_not article.save
  end

  test "should not save article without description" do
    article = Article.new(
      user_id: 1,
      description: 'testtesttesttesttest'
    )

    assert_not article.save
  end
end
