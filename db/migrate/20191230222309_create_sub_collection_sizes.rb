class CreateSubCollectionSizes < ActiveRecord::Migration[5.2]
  def up
    create_table :sub_collection_sizes do |t|
      t.string :subscription_id
      t.string :product_collection
      t.string :leggings
      t.string :tops
      t.string :sports_bra
      t.string :sports_jacket
      t.string :gloves
      t.boolean :prepaid, default: false
      t.datetime :next_charge_scheduled_at
      t.timestamps
    end
  end
  def down
    drop_table :sub_collection_sizes

  end
end
