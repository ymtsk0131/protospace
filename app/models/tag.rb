class Tag < ActiveRecord::Base
  has_many :prototype_tags
  has_one :prototype, through: :prototype_tags

  validates :name, presence: true

  def get_prototype_count
    self.prototype_tags.count
  end
end
