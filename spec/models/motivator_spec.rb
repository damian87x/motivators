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

require 'spec_helper'

describe Motivator do
  pending "add some examples to (or delete) #{__FILE__}"
end
