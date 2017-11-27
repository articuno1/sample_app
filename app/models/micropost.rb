class Micropost < ApplicationRecord
  belongs_to :user
  scope :order_by_date, ->{order created_at: :desc}
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.content.maximum_length}
end
