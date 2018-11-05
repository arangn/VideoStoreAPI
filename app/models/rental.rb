class Rental < ApplicationRecord
  belongs_to_many :movies, :customers


  validates :check_in_date, :check_out_date, presence: true
end
