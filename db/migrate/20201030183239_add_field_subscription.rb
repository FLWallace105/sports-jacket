class AddFieldSubscription < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :is_prepaid, :boolean, default: false
  end
end
