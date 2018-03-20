class DropEndReason < ActiveRecord::Migration
  def change
    drop_table :end_reasons
  end
end
