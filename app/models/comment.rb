class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :prototype
  validates :comment, presence: true

end
