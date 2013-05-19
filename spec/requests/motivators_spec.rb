require 'spec_helper'

describe "Motivators" do
  subject { page }
  let(:user) { FactoryGirl.create(:user)}
  before do
    @motivator = FactoryGirl.create(:motivator, user: user)
  end

  describe "actions motivator" do
    before { sign_in user }

    describe "show" do
      before do
        visit motivator_path(@motivator)
      end

      describe "page" do
        it { current_path.should == motivator_path(@motivator) }
        it { should have_content(@motivator.description) }
        it { should have_content(@motivator.user.name) }
        it { should have_selector('img') }
        it { should have_selector('a', text: "Back") }

        describe "should link 'Back' works" do
          before { find_link('Back').click }
          it { current_path.should == motivators_path  }
        end

      end

    end

    describe "creation" do
      before { visit new_motivator_path }

      describe "page" do
        it { should have_selector('h1',text:'New motivator') }
        it { should have_selector('a', text: "Back") }

        describe "should link 'Back' works" do
          before { find_link('Back').click }
          it { current_path.should == motivators_path  }
        end

      end




      describe "with invalid information" do

        describe "should not create a motivator" do
          before { click_button 'Create Motivator' }

          it { should have_content("Please review the problems below:") }
        end

      end


      describe "with valid information" do
        before { fill_in "Description", with: "lorem linpus" }

        describe "picture attached" do
          before do
            attach_file 'Upload an image', "spec/fixtures/images/rails.jpg"
            click_button 'Create Motivator'
          end

          it { should have_content("Motivator was successfully created and waiting for Approval by Admin")}
          it { should_not have_content("Please review the problems below:")}
        end

        describe "picture from url" do
          before do
            fill_in "or enter a URL", with: "http://goo.gl/Tm6HA"
            click_button "Create Motivator"
          end

          it { should have_content("Motivator was successfully created and waiting for Approval by Admin")}
          it { should_not have_content("Please review the problems below:")}

        end
      end

    end

    describe "destruction" do

      describe "as correct user" do

        describe "should delete motivator" do
          before do
            visit motivator_path(@motivator)
            click_link "Destroy"
          end

          it { should have_content("Motivator was successfully deleted.") }
        end
      end

    end


    describe "edit" do
      before do
        visit motivator_path(@motivator)
        click_link "Edit"
      end

      describe "page" do
        it { should have_selector('h1',text:'Edit motivator') }
        it { should have_selector('a', text: "Back") }

        describe "should link 'Back' works" do
          before { find_link('Back').click }
          it { current_path.should == motivators_path  }
        end

      end

      it { current_path.should == edit_motivator_path(@motivator) }

      describe "with invalid information" do
        before do
          fill_in "Description", with: " "
          click_button "Update Motivator"
        end

        it { should have_content('Please review the problems below:') }
      end

    end

  end

  describe "index" do


    describe "motivator approved" do
      before { @motivator = FactoryGirl.create(:motivator, user: user) }
      describe "when approved" do

        describe "should be see on index page" do
          before do
            @motivator.approved = "true"
            @motivator.save!
            visit root_path
          end
          it { should have_content("Posted by") }
          it { should have_selector('img') }
          it { should have_selector('a', text: user.name) }
          it { should have_content(@motivator.description)}
        end
      end

      describe "when not approved" do

        describe "should be not see on index page" do
          before { visit root_path }

          it { should_not have_content(@motivator.description)}
        end
      end

    end


    describe "pagination" do
      before(:each) { 25.times { FactoryGirl.create(:motivator, approved: "true" , user:user) }  }
      after(:all)  { Motivator.delete_all }

      describe "on index page" do
        before { visit root_path}

        it { should have_selector('div.pagination') }
        it "should have_selector" do

          Motivator.paginate(page: 2).each do |motivator|
            should have_content(motivator.description)
          end
        end
      end
    end
  end
end

