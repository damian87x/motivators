require 'spec_helper'

describe "Pages" do

  let(:base_title) { "Motivators - Get inspiration and change your life now!" }


  subject { page }

  describe "About page" do

    before { visit about_path }
    it {should have_selector('h1',text:'About')}
    it {should have_title("#{base_title} | About")}
    it {should find('a', text: 'Home').click
        current_path.should eq(root_path)  }
    it {should all(:link, 'Motivators' )[2].click
        current_path.should eq(root_path)}
    it {should find('a', text: 'Damian Borek').click
        current_path.should eq(about_path) }
    it {should find('a', text: 'Login').click
        current_path.should eq(new_user_session_path)}
  end



end



