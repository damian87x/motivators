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
  attr_accessible :description
  # this validation model make sure that user don't leave blank description and  user write =< 50 characters
  validates :description, presence: true, length: { maximum: 50}
end
