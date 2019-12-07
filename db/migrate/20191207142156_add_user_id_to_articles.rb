class AddUserIdToArticles < ActiveRecord::Migration[6.0]
  def change
    add_reference :articles, :user, foreign_key: true, after: :id
  end
end
