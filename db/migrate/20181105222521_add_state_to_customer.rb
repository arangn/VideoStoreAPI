class AddStateToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :state, :string
  end
end
