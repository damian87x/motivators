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

  let(:user) { FactoryGirl.create(:user) }
  before { @motivator = user.motivators.build(description: 'Lorem ipsum')}

  subject { @motivator}

  it { should respond_to(:id)}
  it { should respond_to(:description)}
  it { should respond_to(:created_at)}
  it { should respond_to(:updated_at)}
  it { should respond_to(:user_id)}
  it { should respond_to(:image_file_name)}
  it { should respond_to(:image_content_type)}
  it { should respond_to(:image_file_size)}
  it { should respond_to(:image_updated_at)}
  it { should respond_to(:image_remote_url)}
  it { should respond_to(:approved)}
  it { should respond_to(:user) }
  its(:user) { should == user }

  describe "when user_id is not present" do
    before { @motivator.user_id = nil }

    it { should_not be_valid }
  end

  describe "with blank description" do
    before { @motivator.description = " " }

    it { should_not be_valid }
  end

  describe "when description is to long" do
     before { @motivator.description = "a" * 51 }

     it { should_not be_valid}
  end

  describe "when image is not set to upload" do
    before {@motivator.image_file_name = nil}
    it { should_not be_valid}
  end

  describe "when image is blank" do
    before {@motivator.image_file_name = " "}
    it { should_not be_valid}
  end

  describe "when url image is blank"  do
    before {@motivator.image_remote_url = " "}
    it { should_not be_valid}
  end

  describe "when url image is not present"  do
    before {@motivator.image_remote_url = nil}
    it { should_not be_valid}
  end

  describe "should work image url when set" do
    before {@motivator.image_file_name = " "
            @motivator.image_remote_url = ("http://www.guestcentric.com/wp-content/uploads/2012/02/url.jpg")}
    it { should be_valid}
  end


end