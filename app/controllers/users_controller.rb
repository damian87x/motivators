class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @motivators = Motivator.where(approved: true).order("created_at desc").page(params[:page]).per_page(15)
  end
end
