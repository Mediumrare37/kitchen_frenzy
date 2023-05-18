class Booking < ApplicationRecord
  STATUS = ['accepted', 'rejected', 'pending', 'past']

  belongs_to :kitchen
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true, inclusion: { in: STATUS }

  def pending?
    status == 'pending'
  end
end
