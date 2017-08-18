class Item < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :brand
  has_many :allotments
  has_many :user, through: :allotments, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2 }, uniqueness: { case_sensitive: false }
  validates :brand, presence: true
  validates :quantity, presence: true, length: { minimum: 0 }, numericality: { only_integer: true }
  validates :time_of_procurement, presence: true, length: { minimum: 1 }, numericality: { only_integer: true }
  validates :buffer_quantity, presence: true, length: { minimum: 1 }, numericality: { only_integer: true }
end
