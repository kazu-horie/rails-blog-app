class AddFullTextIndexToArticles < ActiveRecord::Migration[6.0]
  def change
    execute 'CREATE FULLTEXT INDEX index_articles_on_title ON articles (title) WITH PARSER ngram;'
  end
end
