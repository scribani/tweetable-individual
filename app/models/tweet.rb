class Tweet < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations
  validates :body, presence: true, length: { maximum: 140 }
end
