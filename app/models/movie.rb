class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, :overview, :release_date, :inventory, :available_inventory, presence: true
  validates :inventory, numericality: {only_integer: true}
  validates :available_inventory, numericality: {only_integer: true}

end
