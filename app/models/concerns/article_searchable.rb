module ArticleSearchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    index_name "articles_#{Rails.env}"

    settings analysis: analyzer_settings do
      mapping do
        indexes :id,          type: 'integer'
        indexes :user_id,     type: 'integer'
        indexes :title,       type: 'text', analyzer: 'custom_kuromoji'
        indexes :description, type: 'text', analyzer: 'custom_kuromoji'
      end
    end

    after_commit on: [:create] do
      __elasticsearch__.index_document
    end

    after_commit on: [:update] do
      __elasticsearch__.update_document
    end

    after_commit on: [:destroy] do
      __elasticsearch__.delete_document
    end

    def self.search(columns:, keywords:)
      __elasticsearch__.search(
        query: {
          multi_match: {
            query: keywords,
            fields: columns,
            type: 'cross_fields'
          }
        }
      ).records
    end
  end

  class_methods do
    def create_index!
      client = __elasticsearch__.client

      begin
        client.indices.delete index: index_name
      rescue StandardError
        nil
      end

      client.indices.create(
        index: index_name,
        body: {
          settings: settings.to_hash,
          mappings: mappings.to_hash
        }
      )
    end

    def analyzer_settings
      {
        analyzer: {
          custom_kuromoji: {
            type: 'custom',
            char_filter: [],
            tokenizer: 'kuromoji_tokenizer',
            filter: [
              'kuromoji_baseform',
              'kuromoji_part_of_speech',
              'cjk_width',
              'kuromoji_stemmer',
              'lowercase',
              'synonym'
            ]
          }
        },
        filter: {
          synonym: {
            type: 'synonym',
            synonyms: [
              '旅館,お宿,旅亭 => ホテル'
            ]
          }
        }
      }
    end
  end
end
