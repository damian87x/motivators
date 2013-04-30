# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#  slug                   :string(255)
#  admin                  :boolean
#

require 'spec_helper'

describe User do
=begin
 # create user by factoryGirl
  before(:each) do
    @user = FactoryGirl.create(:user)
  end
=end

  before do
    @user = User.new(name: "Test User",
                     email: "user@example.com",
                     password: "12345abcd",
                     password_confirmation: "12345abcd" )
  end


  subject {@user}


  it { should respond_to(:id) }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:sign_in_count) }
  it { should respond_to(:remember_created_at) }
  it { should respond_to(:current_sign_in_at) }
  it { should respond_to(:last_sign_in_at) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:admin) }
  it { should respond_to(:current_sign_in_ip) }
  it { should respond_to(:last_sign_in_ip ) }
  it { should respond_to(:slug) }
  it { should respond_to(:reset_password_token) }
  it { should respond_to(:reset_password_sent_at) }
  it { should respond_to(:encrypted_password) }
  it { should_not be_admin }





  describe "should be admin user'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }

  end

  describe "Validates"  do

    describe "should require a name" do
      before { @user.name = " " }

      it { should_not be_valid }
    end

    describe "should require a email" do
      before { @user.email = " " }

      it { should_not be_valid }
    end


    describe "should require a password" do
      before { @user.password = " " }

      it { should_not be_valid }
    end


    describe "should require a password_confirmation" do
      before { @user.password_confirmation = " " }

      it { should_not be_valid }
    end

    describe "email" do

        describe "should accept valid addresses" do
        addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
        addresses.each do |address|
          before { @user.email = address }

          it { should be_valid }
        end
      end


      describe "should reject invalid addresses" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
        addresses.each do |address|
          before { @user.email = address }

          it { should_not be_valid }
        end
      end

=begin
  # work with factory girl
  describe "should reject duplicate email addresses" do
    let(:user_with_duplicate_email)  {@user.dup}
    before do
      user_with_duplicate_email.email = @user.email.upcase
      user_with_duplicate_email.save
    end
    specify {user_with_duplicate_email.should_not be_valid}
  end
=end

      describe "should reject duplicate email addresses" do
        before do
          user_with_duplicate_email = @user.dup
          user_with_duplicate_email.email = @user.email.upcase
          user_with_duplicate_email.save
        end

        it { should_not be_valid }
      end
    end

   describe "Password" do

     describe "when a password to short" do
       before { @user.password = @user.password_confirmation = "a" * 7 }
     end


     describe "should be valid with valid attributes" do
       before { @user.password = @user.password_confirmation = "a" * 8 }

       it {should be_valid}
     end

     describe "when password doesn't match" do
       before { @user.password_confirmation = "unmatch" }
       it { should_not be_valid }
     end


     describe "password encryption" do
       before {@user.encrypted_password}
       it {should_not be_blank}
     end


   end
  end

end
