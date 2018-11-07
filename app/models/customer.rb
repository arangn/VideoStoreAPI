class Customer < ApplicationRecord
  has_many :rentals
  has_many :movies, through: :rentals

  validates :name, :registered_at, :address, :city, :state, :postal_code, :phone, :movies_checked_out, presence: true


end
