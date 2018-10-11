class AddconstraintOrderstable < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      alter table orders
        add constraint ord_id unique (order_id);
    SQL
  end

  def down
    execute <<-SQL
      alter table orders
        drop constraint if exists ord_id;
    SQL
  end
end
