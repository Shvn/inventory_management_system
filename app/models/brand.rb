class Brand < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2 }, uniqueness: true, uniqueness: { case_sensitive: false }
end
