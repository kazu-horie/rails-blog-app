class AddFullTextIndexToArticles < ActiveRecord::Migration[6.0]
  def change
    add_index :articles, :title, type: :fulltext
  end
end
