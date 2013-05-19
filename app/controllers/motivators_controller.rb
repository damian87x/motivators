class MotivatorsController < ApplicationController
before_filter :authenticate_user!, except: [:index]

  def index
    @title ="homepage"
    @motivators = Motivator.where(approved: true).page(params[:page]).per_page(15)
  end

  def new
    @title ="New motivator"
    @motivator = current_user.motivators.new
  end

  def create
    @motivator = current_user.motivators.new(params[:motivator])
    if @motivator.save
      redirect_to(@motivator, notice: 'Motivator was successfully created and waiting for Approval by Admin')
    else
      render ('new')
    end
  end

  def edit
    @title ="Edit motivator"
    @motivator = current_user.motivators.find(params[:id])
  end


  def update
    @motivator = Motivator.find(params[:id])
    if @motivator.update_attributes(params[:motivator])
      redirect_to(@motivator, notice: 'Motivator was successfully updated.')
    else
      render ('edit')
    end
  end

  def show
    @title ="Show motivator"
    @motivator = Motivator.find(params[:id])
  end

  def destroy
    @motivator =  current_user.motivators.find(params[:id])
    @motivator.destroy
    redirect_to(root_path, notice: 'Motivator was successfully deleted.' )
  end



end
