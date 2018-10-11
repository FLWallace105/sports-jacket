class AddconstraintOrderbillingAddress < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      alter table order_billing_address
        add constraint ord_bill unique (order_id);
    SQL
  end

  def down
    execute <<-SQL
      alter table order_billing_address
        drop constraint if exists ord_bill;
    SQL
  end
end
