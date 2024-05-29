class Brand < ApplicationRecord
  belongs_to :user
  has_many :custom_fields, as: :customizable ,dependent: :destroy
  has_many :products, dependent: :destroy

  validate :custom_fields_count_within_limit

  MAXIMUM_CUSTOM_FIELDS = 5
  accepts_nested_attributes_for :custom_fields, allow_destroy: true

  private

  def custom_fields_count_within_limit
    if custom_fields.size > MAXIMUM_CUSTOM_FIELDS
      errors.add(:custom_fields, "cannot have more than #{MAXIMUM_CUSTOM_FIELDS} custom fields")
    end
  end
end
