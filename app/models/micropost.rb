class Micropost < ApplicationRecord
  belongs_to :user
  scope :order_by_date, ->{order created_at: :desc}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.content.maximum_length}
  validate  :picture_size
  scope :order_by_date, ->{order(created_at: :desc)}
  scope :by_users, ->(following_ids,id){
    where("user_id IN (?) OR user_id = ?", following_ids, id)}

  private

  def picture_size
    if picture.size > Settings.size.image.megabytes
      errors.add :picture, t("microposts.model.error")
    end
  end
end
