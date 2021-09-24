class AddEmailPrepaidSubs < ActiveRecord::Migration[5.2]
  def change
    add_column :subscriptions, :is_prepaid, :boolean
    add_column :subscriptions, :email, :string
  end
end
