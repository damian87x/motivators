# == Schema Information
#
# Table name: motivators
#
#  id                 :integer          not null, primary key
#  description        :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :integer
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  image_remote_url   :string(255)
#  approved           :boolean          default(FALSE)
#

class Motivator < ActiveRecord::Base
  attr_accessible :description, :image, :image_remote_url, :user_id, :approved
  belongs_to :user
  validates_attachment :image, presence: true,
                       content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
                       size: { less_than: 5.megabytes }
  has_attached_file :image, styles: { medium: "320x240>", large:"620x440" }
  # this validation model make sure that user don't leave blank description and  user write =< 50 characters
  validates :description, presence: true, length: { maximum: 50}
  validates :user_id, presence: true

  def image_remote_url=(url_value)
    # if url blank, don't try convert url.
    self.image = URI.parse(url_value) unless url_value.blank?
    # super method
    super
  end

  def to_s
    description
  end



end
