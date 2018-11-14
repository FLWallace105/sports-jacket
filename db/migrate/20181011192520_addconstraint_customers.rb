class AddconstraintCustomers < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      alter table customers
        add constraint cust_constraint unique (customer_id);
    SQL
  end

  def down
    execute <<-SQL
      alter table customers
        drop constraint if exists cust_constraint;
    SQL
  end
end
