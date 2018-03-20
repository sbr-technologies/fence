class CreateLookupTypeCodes < ActiveRecord::Migration
  def change
    create_table :lookup_type_codes do |t|
      t.references :business, index: true
      t.string :description
      t.text :long_description
      t.boolean :active
      t.integer :created_by
      t.integer :modified_by

      t.timestamps null: false
    end
    add_foreign_key :lookup_type_codes, :businesses
  end
end
