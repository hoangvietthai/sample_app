class Micropost < ApplicationRecord
  belongs_to :user
  scope :order_desc, ->{order created_at: :desc}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.maximum_name}
  validate  :picture_size
  private
  def picture_size
    errors.add(:picture, t(".should")) if picture.size > Settings.mega.megabytes
  end
end
