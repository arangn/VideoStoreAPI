class Rental < ApplicationRecord
  belongs_to :movies
  belongs_to :customers


  validates :due_date, :check_out_date, presence: true
end
