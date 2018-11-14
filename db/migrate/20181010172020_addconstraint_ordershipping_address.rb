class AddconstraintOrdershippingAddress < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      alter table order_shipping_address
        add constraint ord_ship unique (order_id);
    SQL
  end

  def down
    execute <<-SQL
      alter table order_shipping_address
        drop constraint if exists ord_ship;
    SQL
  end
end
