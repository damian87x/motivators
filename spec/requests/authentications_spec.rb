require 'spec_helper'
include Devise::TestHelpers
describe "Authentications" do

  subject { page }

  describe "login page" do
    before { visit new_user_session_path }

    it { should have_content('Sign in') }
    it { should have_content('a', text: 'Sign in') }
    it { should have_content('a', text: 'Sign up') }
  end


  describe "login" do
    before {visit new_user_session_path}

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_content('Sign in') }
      it { should have_content('Invalid') }

      describe "after visiting another page" do
        before { click_link "Home"}

        it { should_not have_selector('div.alert.alert-alert') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email", with: user.email.upcase
        fill_in "Password", with: user.password
        check('Remember me')
        click_button "Sign in"
      end

      it { should have_link('Logout', href: destroy_user_session_path) }
      it { should have_link('Add +', href: new_motivator_path) }
      it { should have_link('Edit Profile', href: edit_user_registration_path) }
      it { should have_content('Signed in successfully.') }
      it { should_not have_link('Admin Panel:', href: admin_root_path) }
      it { should_not have_link('Motivators', href: admin_motivators_path) }
      it { should_not have_link('Users', href: admin_users_path) }
      it { should_not have_link('Login', href: new_user_session_path) }

      describe "when Logout" do
        before { click_link 'Logout' }
        it { should have_link('Login') }
      end
    end

    describe "with Admin user" do
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        fill_in 'Email', with: admin.email.upcase
        fill_in 'Password', with: admin.password
        click_button "Sign in"
      end
      it { should have_link('Admin Panel:', href: admin_root_path) }
      it { should have_link('Motivators', href: admin_motivators_path) }
      it { should have_link('Users', href: admin_users_path) }

      describe "when visiting admin panel" do
        describe "root page" do
          before { click_link 'Admin Panel:' }
          it { should have_content("Dashboard")}
        end

        describe "motivators page" do
          before { click_link 'Motivators', href: admin_motivators_path  }
          it { should have_content("Approved")}
        end

        describe "motivators page" do
          before { click_link 'Users', href: admin_users_path  }
          it { should have_content("Admins")}
        end
      end

      describe "when Logout" do
        before { click_link 'Logout' }
        it { should have_link("Login") }
      end
    end
  end


  describe "authorization" do
    let(:user) { FactoryGirl.create(:user) }
    let(:motivator) { FactoryGirl.create(:motivator) }
    describe "For non-signed-in users" do

      describe "login in" do
        before do
          visit edit_user_registration_path
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end
        describe "after signing in" do

          it "should be in sign in page" do
            current_path.should eq(edit_user_registration_path)
          end

          it { should have_content("Edit User") }
        end
      end

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_registration_path(user) }
          it { current_path.should eq(edit_user_registration_path(user)) }
          it { should have_content("You need to sign in or sign up before continuing.") }
        end

        describe "visiting the user profile" do
          before { visit user_path(user)}
          it { should have_content(user.name) }
        end

     end

      describe "in the Motivators controller" do

        describe "submitting to the create action" do
          before { post motivators_path }
          specify { response.should redirect_to(new_user_session_path) }
        end

        describe "submitting to the delete action" do
          before { delete motivator_path(motivator) }
          specify { response.should redirect_to(new_user_session_path) }
        end

        describe "submitting to the update action" do
          before { put motivator_path(motivator) }
          specify { response.should redirect_to(new_user_session_path) }
        end

        describe "visiting the edit page" do
          before { visit edit_motivator_path(motivator) }
          specify { current_path.should == new_user_session_path }
        end
      end


      describe "in the Admin Panel non-signed-in user should not access" do

        describe "visiting admin panel welcome page" do
          before { visit  admin_root_path(user) }
          specify { current_path.should == new_user_session_path }
        end

        describe "to motivators"  do

          describe "visiting list page "  do
            before { visit admin_motivators_path}
            specify { current_path.should == new_user_session_path  }
          end

          describe "visiting edit page" do
            before { get edit_admin_motivator_path(motivator)}
            specify { response.should redirect_to(new_user_session_path) }
          end

          describe "submitting to the update action" do
            before { put admin_motivator_path(motivator)}
            specify { response.should redirect_to(new_user_session_path) }
          end


          describe "submitting to the delete action" do
            before { delete admin_motivator_path(motivator)}
            specify { response.should redirect_to(new_user_session_path) }
          end

        end

        describe "to users"  do

          describe "visiting users list page" do
            before { visit admin_users_path}
            specify { current_path.should == new_user_session_path }
          end


          describe "visiting users edit page" do
            before { get edit_admin_user_path(user)}
            specify { response.should redirect_to(new_user_session_path) }
          end


          describe "submitting to the update action" do
            before { put admin_user_path(user)}
            specify { response.should redirect_to(new_user_session_path) }
          end

          describe "submitting to the delete action" do
            before { delete admin_user_path(user)}
            specify { response.should redirect_to(new_user_session_path) }
          end
        end

      end

    end


    describe "in the Admin Panel signed-in user should not access to" do
      before do
        visit new_user_session_path
        fill_in "Email", with: user.email.upcase
        fill_in "Password", with: user.password
        check('Remember me')
        click_button "Sign in"
      end

      describe "visiting admin panel welcome page" do
        before { visit  admin_root_path }
        it { should have_content("You are already signed in.")  }
        it { current_path.should_not == admin_root_path }
      end

      describe "for users admin panel" do
        describe "visiting list page" do
          before { visit  admin_users_path }
          it { should have_content("You are already signed in.")  }
          it { current_path.should_not == admin_users_path }
        end


        describe "submitting to the update action" do
          before { put admin_user_path(user)}
          specify{ response.should redirect_to(new_user_session_path) }
        end


        describe "submitting to the delete action" do
          before { delete admin_user_path(user)}
          specify { response.should redirect_to(new_user_session_path) }
        end

        describe "visiting users edit page" do
          before { get edit_admin_user_path(user)}
          specify { response.should redirect_to(new_user_session_path) }
        end

      end


      describe "for motivators admin panel" do
        describe "visiting list page " do
          before { visit admin_motivators_path}
          it { should have_content("You are already signed in.")  }
          it { current_path.should_not == admin_users_path }
        end

        describe "visiting edit page" do
          before { get edit_admin_motivator_path(motivator)}
          specify { response.should redirect_to(new_user_session_path) }
        end


        describe "submitting to the update action" do
          before { put admin_motivator_path(motivator)}
          specify { response.should redirect_to(new_user_session_path) }
        end


        describe "submitting to the delete action" do
          before { delete admin_motivator_path(motivator)}
          specify { response.should redirect_to(new_user_session_path) }
        end


      end

    end
  end
end











