class Movie < ApplicationRecord
  validates :title, :overview, :release_date, :inventory, presence: true
  validates :inventory, numericality: {only_integer: true}
end
