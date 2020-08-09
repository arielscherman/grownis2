class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  has_many :depots
  has_many :bugs
  has_many :suggestions
  has_many :messages, class_name: "User::Message"

  validates :username, presence: true

  scope :support, -> { where(email: "arielscherman@gmail.com") }
  scope :owner, -> { where(email: "arielscherman@gmail.com") }
end
