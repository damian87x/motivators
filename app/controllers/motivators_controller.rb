class MotivatorsController < ApplicationController


  def index
    @title ="homepage"
    @motivators = Motivator.all
  end

  def new
    @title ="new Motivator"
    @motivator = Motivator.new
  end

  def create
    @motivator = Motivator.new(params[:motivator])
    if @motivator.save
      redirect_to(@motivator, notice: 'Motivator was successfully created.')
    else
      render ('new')
    end
  end

  def edit
    @title ="edit Motivator"
    @motivator = Motivator.find(params[:id])
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
    @title ="show Motivator"
    @motivator = Motivator.find(params[:id])
  end

  def destroy
    @motivator = Motivator.find(params[:id])
    @motivator.destroy
    redirect_to(root_path, notice: 'Motivator was successfully deleted.' )
  end
end
