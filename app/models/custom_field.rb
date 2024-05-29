class CustomField < ApplicationRecord
  belongs_to :customizable, polymorphic: true
  validates :key, presence: true
end
