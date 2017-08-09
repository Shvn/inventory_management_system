class Person < ApplicationRecord
  has_many :allotments
  has_many :items, through: :allotments, dependent: :destroy

  before_save { self.name = name.titleize }
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :mobile, presence: true, length: { is: 10 }, numericality: { only_integer: true }
end
