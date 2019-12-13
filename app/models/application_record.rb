class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def update(params)
    super(params)

    self.class.write_cache(self)
  end

  class << self
    def find(id)
      record = read_cache(id)

      return record if record

      record = super(id)

      write_cache(record)

      record
    end

    def cache_key(record_id)
      "#{to_s.downcase.pluralize}/#{record_id}"
    end

    def read_cache(record_id)
      serialized_record = Rails.cache.read(cache_key(record_id))

      return unless serialized_record

      Article.allocate.init_with(serialized_record)
    end

    def write_cache(record)
      serialized_record = {}
      record.encode_with(serialized_record)
      Rails.cache.write(cache_key(record.id), serialized_record)
    end
  end
end
