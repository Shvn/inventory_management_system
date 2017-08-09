class Category < ApplicationRecord
  has_many :items, dependent: :destroy

  before_save { self.name = name.titleize }
  validates :name, presence: true, length: { minimum: 2 }, uniqueness: { case_sensitive: false }
end
