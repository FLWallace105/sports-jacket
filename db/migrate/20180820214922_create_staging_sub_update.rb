class CreateStagingSubUpdate < ActiveRecord::Migration[5.1]
  def up
    create_table :staging_subscriptions_update do |t|
      t.string :subscription_id
      t.string :product_title
      t.decimal :price, precision: 10, scale: 2
      t.string :shopify_product_id
      t.string :shopify_variant_id
      t.string :sku
      t.jsonb :raw_line_item_properties
      t.boolean :is_updated, default: false
      t.datetime :updated_at
     
      
    end
    
    
  end

  def down
    
    drop_table :staging_subscriptions_update
    
    
  end
end
