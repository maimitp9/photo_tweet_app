class Image < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :title, presence: true, length: { maximum: 30 }
  validate :photo? # custome validation for photo required field

  scope :by_user, -> (user) { where(user_id: user.id)}
  scope :order_updated_at, -> { order(updated_at: :desc)}

  private # PRIVATE METHOD
  def photo?
    errors.add(:base, I18n.t('screen.images.errors.reuired_file')) unless photo.attached?
  end
end