class AddSubcriptionIdToReports < ActiveRecord::Migration[5.1]
  def change
    add_column :reports, :subscription_id, :string
  end
end
