class CreateLookupItemCodes < ActiveRecord::Migration
  def change
    create_table :lookup_item_codes do |t|
      t.references :business, index: true
      t.references :lookup_type_code, index: true
      t.string :description
      t.text :long_description
      t.boolean :active
      t.integer :created_by
      t.integer :modified_by

      t.timestamps null: false
    end
    add_foreign_key :lookup_item_codes, :businesses
    add_foreign_key :lookup_item_codes, :lookup_type_codes
  end
end
