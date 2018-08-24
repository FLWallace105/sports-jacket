class ElliestagingSubsNextMonth < ActiveRecord::Migration[5.1]
  def up
    create_table :staging_next_month do |t|
      t.integer :sub_type
      t.string :product_title
      t.string :shopify_product_id
      t.string :shopify_variant_id
      t.string :sku
      t.string :product_collection
     
      
    end
    
    
  end

  def down
    
    drop_table :staging_next_month
    
    
  end
end
