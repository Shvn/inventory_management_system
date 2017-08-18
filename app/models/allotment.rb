class Allotment < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_many :allotment_histories, dependent: :destroy

  validates :item_id, presence: true, uniqueness: { scope: :user_id }
  validates :user_id, presence: true, uniqueness: { scope: :item_id }
  validates :status, presence: true

  after_save :add_history

  scope :order_descending,        -> { order('created_at DESC') }
  scope :find_item_allotments,    -> (id) { joins(:item, :user).where(item_id: id) }
  scope :find_user_allotments,    -> (id) { joins(:item, :user).where(user_id: id) }

  def add_history
    allotment_history = AllotmentHistory.new(allotment_id: id, action: status)
    allotment_history.save
  end

  def deallocated
    status == 'Deallocated'
  end

  def allocated
    status == 'Allocated'
  end

  def buffer_quantity_reached
    item.quantity == item.buffer_quantity + 1
  end
end
