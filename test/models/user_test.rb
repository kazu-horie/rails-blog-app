require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "should not save user without name" do
    user = User.new(
      password: 'password'
    )
  
    assert_not user.save
  end

  test "should not save user without password" do
    user = User.new(
      name: 'alice'
    )

    assert_not user.save
  end
end
