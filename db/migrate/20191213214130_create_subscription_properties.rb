class CreateSubscriptionProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :subscription_properties do |t|
      t.string :subscription_id
      t.string :product_collection
      t.string :leggings
      t.string :tops
      t.string :gloves
      t.string :"sports-bra"
      t.string :"sports-jacket"
      t.string :unique_identifier
      t.string :charge_interval_frequency
      t.string :charge_interval_unit_type
      t.string :"main-product"
      t.string :product_id
      t.string :referrer
      t.string :shipping_interval_frequency
      t.string :shipping_interval_unit_type
      t.datetime :created_at
      t.datetime :updated_at
    end
      add_index :subscription_properties, :subscription_id
  end
end
