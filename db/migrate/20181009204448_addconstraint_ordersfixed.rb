class AddconstraintOrdersfixed < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      alter table order_line_items_fixed
        add constraint ord_fixed unique (order_id);
    SQL
  end

  def down
    execute <<-SQL
      alter table order_line_items_fixed
        drop constraint if exists ord_fixed;
    SQL
  end
end
