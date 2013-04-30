require 'spec_helper'

describe ApplicationHelper do

  describe "full_title" do
    it "should include the base title" do
      title.should match(/^Motivators - Get inspiration and change your life now!/)
    end

  end
end