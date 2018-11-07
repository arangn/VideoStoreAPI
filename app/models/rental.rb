class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer


  validates :due_date, :check_out_date, presence: true
end
