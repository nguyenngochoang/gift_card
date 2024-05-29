class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :brand_id, :user_id, :created_at, :deleted_at,
             :price_cents, :price_currency,:formated_price, :custom_price, :custom_fields

  def formated_price
    object.price.format
  end

  def custom_price
    return "" unless instance_options[:user_currency]

    object.price.exchange_to(instance_options[:user_currency]).format
  end

  def custom_fields
    object.custom_fields.map do |custom_field|
      {
        key: custom_field.key,
        value: custom_field.value
      }
    end
  end
end
