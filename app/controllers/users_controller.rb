class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @motivators = @user.motivators.page(params[:page]).per_page(15)
  end
end
