class Rental < ApplicationRecord
  validates :check_in_date, :check_out_date, presence: true
end
