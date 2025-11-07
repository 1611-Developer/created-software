class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :user_name, presence: true
  validates :user_name, uniqueness: { case_sensitive: false }

  validates :agree_to_terms, acceptance: true

  has_many :posts, dependent: :destroy
end
