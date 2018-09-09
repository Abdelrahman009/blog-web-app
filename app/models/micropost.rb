class Micropost < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  default_scope -> {order('created_at DESC')}
  validates :user_id, presence: true
  validates :content, presence: true ,length: {maximum: 140}
  validate :picture_size

  private

  def picture_size
    if picture.size > 5.megabyte
      errors.add(:picture,"pictures must be smaller than 5MB")
    end
  end


end
