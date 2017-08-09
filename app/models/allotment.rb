class Allotment < ApplicationRecord
  belongs_to :item
  belongs_to :person
  has_many :allotment_histories

  validates :item_id, presence: true, uniqueness: { scope: :person_id }
  validates :person_id, presence: true, uniqueness: { scope: :item_id }
  validates :status, presence: true

  after_save :add_history

  scope :order_descending, -> { order('created_at DESC') }
  scope :find_item_allotments, -> (id) { joins(:item, :person).where(item_id: id) }
  scope :find_person_allotments, -> (id) { joins(:item, :person).where(person_id: id) }

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
end
