class Rental < ApplicationRecord
  belongs_to :movies
  belongs_to :customers


  validates :check_in_date, :check_out_date, presence: true
end
