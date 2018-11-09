class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer


  validates :movie_id, :customer_id, :due_date, :check_out_date, presence: true

  # Generates an ID? -- Controller
  # Calcluate due date based on check_out_date
  # Generate Overdue status based on due date and check_in_date

  def check_out_movie(customer, movie)

    available = movie.available_inventory
    movie.update(available_inventory: available - 1)

    checked_out = customer.movies_checked_out_count
    customer.update(movies_checked_out_count: checked_out + 1)
  end

  def check_in_movie(customer, movie)

    available = movie.available_inventory
    movie.update(available_inventory: available + 1)

    checked_out = customer.movies_checked_out_count
    customer.update(movies_checked_out_count: checked_out - 1)
  end
end
