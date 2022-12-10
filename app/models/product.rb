class Product < ApplicationRecord
    has_many :product_categories
    has_many :categories, through: :product_categories
    validates :name , presence: true 
    validates :price , numericality: {greater_than_or_equal_to: 1}
    belongs_to :store
    belongs_to :user
    has_many :orders
    has_many :carts ,through: :orders
    has_one_attached :image
    validate :deadline_is_possible?

   def deadline_is_possible?
    if production_date > expiration_date
      errors.add(:deadline, 'must be possible')
    end
  end
end
