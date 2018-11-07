class Rental < ApplicationRecord
  belongs_to :movies
  belongs_to :customers


  validates :movie_id, :customer_id, :due_date, :check_out_date, presence: true

  # Generates an ID? -- Controller
  # Calcluate due date based on check_out_date
  # Generate Overdue status based on due date and check_in_date

end
