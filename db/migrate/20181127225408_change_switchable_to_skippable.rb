class ChangeSwitchableToSkippable < ActiveRecord::Migration[5.1]
  def change
    rename_table :switchable_products, :skippable_products
  end
end
