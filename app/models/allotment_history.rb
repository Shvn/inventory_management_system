class AllotmentHistory < ApplicationRecord
  belongs_to :allotment

  validates :allotment_id, presence: true
  validates :action, presence: true

  scope :order_descending,      -> { order('created_at DESC') }
  scope :find_histories,        -> (id) { joins(allotment: [:item, :user]).where(allotment_id: id) }
  scope :find_item_histories,   -> (id) { joins(allotment: [:item, :user]).where('allotments.item_id = ?', id) }
end
