class Brand < ApplicationRecord
  has_many :items
  
  validates :name, presence: true, length: { minimum: 2 }, uniqueness: true
end
