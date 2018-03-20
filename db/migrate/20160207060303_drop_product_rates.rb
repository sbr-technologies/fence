class DropProductRates < ActiveRecord::Migration
  def change
    drop_table :product_rates
  end
end
