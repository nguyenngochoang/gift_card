class CreateCustomFields < ActiveRecord::Migration[7.1]
  def change
    create_table :custom_fields do |t|
      t.references :customizable, polymorphic: true, null: false
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
