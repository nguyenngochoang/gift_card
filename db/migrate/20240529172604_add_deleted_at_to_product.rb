class AddDeletedAtToProduct < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :deleted_at, :datetime
  end
end
