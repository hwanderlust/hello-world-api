class ListsController < ApplicationController

  def create
    list = List.create(list_params)
    if list.valid?
      render json: list
    else
      render json: {error: "list couldn't be created"}
    end
  end

  def show
    list = List.find_by(id: params[:id])

    if list
      render json: list.messages
    else
      render json: {error: "List doesn't exist"}
    end
  end

  def destroy
    list = List.find_by(id: params[:id])
    list.destroy
    
    if list
      render json: {error: "Couldn't delete"}
    else
      render json: {success: "Congrats, it's been deleted"}
    end
  end

  private
  def list_params
    params.require(:list).permit(:name, :user_id)
  end
end
