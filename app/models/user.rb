class User < ApplicationRecord
  # Associations
  has_many :tweets, dependent: :nullify

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :name, presence: true
end
