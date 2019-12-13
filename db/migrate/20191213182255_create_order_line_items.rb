class CreateOrderLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_line_items do |t|
      t.string :order_id
      t.string :subscription_id
      t.integer :quantity
      t.string :shopify_product_id
      t.string :shopify_variant_id
      t.string :price
      t.string :product_title
      t.string :grams
      t.string :vendor
      t.string :sku
      t.string :variant_title
      t.string :charge_interval_frequency
      t.string :charge_interval_unit_type
      t.string :leggings
      t.string :tops
      t.string :"sports-jacket"
      t.string :"sports-bra"
      t.string :gloves
      t.string :product_collection
      t.string :shipping_interval_frequency
      t.string :shipping_interval_unit_type
      t.string :referrer
      t.string :"main-product"
      t.string :product_id
      t.string :unique_identifier
      t.datetime :created_at
      t.datetime :updated_at
    end
      add_index :order_line_items, :order_id
  end
end
