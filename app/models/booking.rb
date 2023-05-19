class Booking < ApplicationRecord
  STATUS = [0, 1, 2, 3]

  belongs_to :kitchen
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true
  # Trying stuff
  enum :status, { pending: 0, accepted: 1, rejected: 2, past: 3 }

  scope :past, -> { where('end_date < ?', Date.today) }
  scope :future, -> { where('start_date > ?', Date.today) }
  scope :active, -> { where('start_date < ? AND end_date > ?', Date.today, Date.today) }
  scope :today, -> { accepted.where(date: Date.today) }
  scope :upcoming, -> { accepted.future }
  scope :need_response, -> { pending.future }
  scope :expired, -> { pending.past }
  scope :completed, -> { accepted.past }
  scope :not_rejected, -> { where.not(status: :rejected) }

  def number_of_days
    (end_date - start_date).to_i
  end

  def price
    kitchen.price_per_day * number_of_days
  end
end
