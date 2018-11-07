class RemoveDueDateFromRentals < ActiveRecord::Migration[5.2]
  def change
    remove_column :rentals, :due_date
  end
end
