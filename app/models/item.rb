class Item < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :brand
  has_many :allotments
  has_many :user, through: :allotments, dependent: :destroy
  has_many :issues, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2 }, uniqueness: { case_sensitive: false }
  validates :brand, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :time_of_procurement, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :buffer_quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def buffer_quantity_reached?
    quantity <= buffer_quantity - 1
  end

  def calculate_priority
    case time_of_procurement
    when 0..3
      "low"
    when 4..6
      "medium"
    else
      "high"
    end
  end

  def available?
    quantity > 0
  end
end
