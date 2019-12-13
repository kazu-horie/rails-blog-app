class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def update(params)
    super(params)

    cache_params = {}
    encode_with(cache_params)
    Rails.cache.write(self.class.cache_key(id), cache_params)
  end

  class << self
    def find(id)
      if Rails.cache.exist?(cache_key(id))
        cache_params = Rails.cache.read(cache_key(id))
        return Article.allocate.init_with(cache_params)
      end

      record = super(id)

      cache_params = {}
      record.encode_with(cache_params)
      Rails.cache.write(cache_key(id), cache_params)

      record
    end

    def cache_key(id)
      "#{to_s.downcase.pluralize}/#{id}"
    end
  end
end
