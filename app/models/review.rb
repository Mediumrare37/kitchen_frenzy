class Review < ApplicationRecord
  belongs_to :user
  belongs_to :kitchen

  validates :user, presence: true, uniqueness: { scope: :kitchen }
  validates :kitchen, presence: true
end
