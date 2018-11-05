class Rental < ApplicationRecord
  has_and_belongs_to_many :movies
  belongs_to :customers


  validates :check_in_date, :check_out_date, presence: true
end
