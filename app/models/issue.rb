class Issue < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :item_id, presence: true
  validates :user_id, presence: true
  validates :status, presence: true
  validates :details, presence: true, length: { minimum: 10 }

  def raised
    status == 'Raised'
  end
end
