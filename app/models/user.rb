class User < ApplicationRecord
  # Associations
  has_many :tweets, dependent: :nullify
  has_many :comments, dependent: :nullify
  has_one_attached :avatar

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :name, presence: true

  # Include default devise modules. Others available are:
  # :recoverable, :rememberable, :confirmable
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable
end
