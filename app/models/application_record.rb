class ApplicationRecord < ActiveRecord::Base
  include RecordCache

  self.abstract_class = true
end
