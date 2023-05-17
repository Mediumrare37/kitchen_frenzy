class Kitchen < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates :details, presence: true
  validates :location, presence: true, uniqueness: true
  validates :price_per_day, presence: true, numericality: { greater_than: 0 }
end
