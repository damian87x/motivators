require 'spec_helper'

describe "Users" do

 subject { page }
 let(:user) { FactoryGirl.create(:user)}

  describe "profile page" do
    before { @motivator = FactoryGirl.create(:motivator, user: user) }

      describe "page" do
        before do
          @motivator.approved = "true"
          @motivator.save!
          visit user_path(user)
        end
        it { should have_content("Posted by") }
        it { should have_selector('a', text: user.name) }
        it { should have_selector('img') }
        it { should have_content(@motivator.description)}
      end
  end

  describe "login page" do
    before { visit new_user_registration_path }

    it { should have_content('Sign in') }
    it { should have_content('a', text: 'Sign in') }
    it { should have_content('a', text: 'Sign up') }
  end


  describe "login" do

    describe "with invalid information" do

      describe "should not create a user" do
        before do
          visit new_user_registration_path
          click_button "Sign up"
        end
        it { should have_content("Please review the problems below:") }
      end

    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
      end

      it { should have_link('Logout', href: destroy_user_session_path) }
      it { should have_link('Add +', href: new_motivator_path) }
      it { should have_link('Edit Profile', href: edit_user_registration_path) }
  end
 end


 describe "edit" do
   before do
     sign_in user
     visit edit_user_registration_path(user)
   end

   describe "page" do
     it { should have_content("Edit User") }
     it { should have_content("Name") }
     it { should have_content("Email") }
     it { should have_content("New Password") }
     it { should have_content("New Password Confirmation") }
     it { should have_content("Current password") }
     it { should have_content("Cancel my account") }
     it { should have_button("Cancel my account") }
     it { should have_link("Back") }
     it { should have_button("Update") }
   end


   describe "with invalid information" do
     before { click_button "Update" }

     it { should have_selector('div.alert.alert-error') }
   end


     describe "with valid information" do
       let(:new_name)  { "New Name" }
       let(:new_email) { "new@mail.com" }
       before do
         fill_in "Name",             with: new_name
         fill_in "Email",            with: new_email
         fill_in "Current password", with: user.password
         click_button "Update"
       end

       it { should have_selector('div.alert.alert-notice') }
       it { should have_link('Logout', href: destroy_user_session_path) }
       specify { user.reload.name.should  == new_name }
       specify { user.reload.email.should == new_email }
     end
   end
end


