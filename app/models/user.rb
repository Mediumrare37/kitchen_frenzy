class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews
  has_many :bookings
  has_many :kitchens, dependent: :destroy
  has_many :bookings_as_owner, through: :kitchens, source: :bookings

  validates :first_name, presence: true
  validates :last_name, presence: true
end
