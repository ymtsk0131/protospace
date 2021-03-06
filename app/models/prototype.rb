class Prototype < ActiveRecord::Base
  belongs_to :user
  has_many :captured_images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :prototype_tags, dependent: :destroy
  has_many :tags, through: :prototype_tags

  accepts_nested_attributes_for :captured_images, reject_if: :reject_sub_images
  accepts_nested_attributes_for :tags, reject_if: :reject_tags

  validates :title,
            :catch_copy,
            :concept,
            presence: true
  validates :prototype_tags, length: { maximum: 3 }

  def reject_sub_images(attributed)
    attributed['content'].blank?
  end

  def reject_tags(attributed)
    attributed['name'].blank?
  end

  def set_main_thumbnail
    captured_images.main.first.content if captured_images.present?
  end

  def posted_date
    created_at.strftime('%b %d %a')
  end

  def get_like_count
    self.likes.count
  end

  def self.random_order(seed)
    if Rails.env == 'production'
      self.select("setseed(#{seed})")
      self.order('random()') # pg
    else
      self.order("RAND(#{seed})") # mysql
    end
  end
end
