class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum :role , [:admin , :customer , :owner]
  has_many :products
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
