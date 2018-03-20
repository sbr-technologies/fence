class DropBusinessContactInfo < ActiveRecord::Migration
  def change
    drop_table :business_contact_infos
  end
end
