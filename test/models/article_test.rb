require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "should not save article without title" do
    article = Article.new(
      title: 'test'
    )
  
    assert_not article.save
  end

  test "should not save article without description" do
    article = Article.new(
      description: 'testtesttesttesttest'
    )

    assert_not article.save
  end
end
