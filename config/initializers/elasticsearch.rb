config = {
  host: ENV['ELASTICSEARCH_HOST'] || "es:9200",
}

Elasticsearch::Model.client = Elasticsearch::Client.new(config)

begin
  if ActiveRecord::Base.connection.table_exists? :articles
    Article.create_index!
    Article.__elasticsearch__.import
  end
rescue ActiveRecord::NoDatabaseError
  nil
end
