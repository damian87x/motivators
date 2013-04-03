# == Schema Information
#
# Table name: motivators
#
#  id          :integer          not null, primary key
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Motivator < ActiveRecord::Base
  attr_accessible :description, :image
  belongs_to :user
  validates_attachment :image, presence: true,
                       content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
                       size: { less_than: 5.megabytes }
  has_attached_file :image, styles: { medium: "320x240>", large:"520x440" }
  # this validation model make sure that user don't leave blank description and  user write =< 50 characters
  validates :description, presence: true, length: { maximum: 50}
  validates :user_id, presence: true
end
