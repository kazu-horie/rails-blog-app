class Article < ApplicationRecord
  include RecordCache
  include ArticleSearchable

  belongs_to :user

  validates :user_id, presence: true
  validates :title, presence: true
  validates :description, presence: true
end
