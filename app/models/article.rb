class Article < ApplicationRecord
  include RecordCache

  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true
  validates :description, presence: true

  class << self
    def search(columns:, keywords:)
      where("MATCH (#{columns.join(',')}) AGAINST (? IN BOOLEAN MODE)", keywords)
    end
  end
end
