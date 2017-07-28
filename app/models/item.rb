class Item < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :brand

  validates :name, presence: true, length: { minimum: 2 }, uniqueness: { case_sensitive: false }
  validates :brand, presence: true
end
