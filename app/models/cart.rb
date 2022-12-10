class Cart < ApplicationRecord
    has_many :orders
    has_many :products ,through: :orders
    validates :quantity  , numericality: {greater_than_or_equal_to: 1}
end
