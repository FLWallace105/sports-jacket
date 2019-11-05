class CreateReports < ActiveRecord::Migration[5.1]
  def up
    create_table :reports do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :shopify_customer_id
      t.string :missing_sports_jacket
      t.string :missing_legging
      t.string :missing_sports_bra
      t.datetime :next_charge_scheduled_at
    end
  end

  def down
    drop_table :reports
  end
end
