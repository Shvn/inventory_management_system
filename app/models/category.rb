class Category < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2 }, uniqueness: true

  before_save { self.name = name.titleize }
end
