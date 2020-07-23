class RoomsController < ApplicationController
  def new
    @room = Room.new
  end

  def create
    @room = Room.create(room_params)
    if @room
      redirect_to root_path
    else
      render :new
    end
  end

  def index
    
  end

  def destroy
    Room.find(params[:id]).destroy
    redirect_to root_path
  end

  private
  def room_params
    params.require(:room).permit(:name, user_ids: [])
  end
end
