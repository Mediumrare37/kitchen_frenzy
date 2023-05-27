class Kitchen < ApplicationRecord
  belongs_to :user
  has_many :bookings#, dependent: :destroy
  has_many :reviews
  has_one_attached :photo

  validates :details, presence: true
  validates :location, presence: true
  validates :price_per_day, presence: true, numericality: { greater_than: 0 }

  # Geocoding
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
