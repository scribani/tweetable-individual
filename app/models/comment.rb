class Comment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :tweet

  # Validations
  validates :body, presence: true, length: { maximum: 140 }
end
