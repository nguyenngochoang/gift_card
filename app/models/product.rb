class Product < ApplicationRecord
  belongs_to :user
  belongs_to :brand
  has_many :custom_fields, as: :customizable ,dependent: :destroy

  monetize :price_cents

  validate :custom_fields_count_within_limit
  accepts_nested_attributes_for :custom_fields, allow_destroy: true

  MAXIMUM_CUSTOM_FIELDS = 5

  private

  def custom_fields_count_within_limit
    if custom_fields.size > MAXIMUM_CUSTOM_FIELDS
      errors.add(:custom_fields, "cannot have more than #{MAXIMUM_CUSTOM_FIELDS} custom fields")
    end
  end
end
