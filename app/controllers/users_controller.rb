class UsersController < ApplicationController

  def index
    users = User.all
    render json: users
  end

  def create
    user = User.find_by(username: user_params[:username].downcase)

    if user
      render json: {error: "Username already taken"}

    else
      user = User.new(username: user_params[:username].downcase, password: user_params[:password], profile_picture: user_params[:profile_picture], location: user_params[:location], age: user_params[:age], nationality: user_params[:nationality], languages: user_params[:languages], introduction: user_params[:introduction], hobbies: user_params[:hobbies], goals: user_params[:goals])

      if user.valid?
        user.save
        ActionCable.server.broadcast "users_channel", user
        List.create(name: "Study", user_id: user.id)
        render json: user
      else
        render json: {error: user.errors}, status: 422
      end
    end

  end

  def login
    user = User.find_by(username: user_params[:username])

    if user && user.authenticate(user_params[:password])
      render json: user
    elsif user
      render json: {error: "Incorrect password"}, status: 401
    else
      render json: {error: "Username may not exist"}, status: 401
    end
  end

  def get_user
    render json: current_user
  end

  def show
    user = User.find_by(id: params[:id])
    puts user
    all_msgs = user.sent_messages + user.received_messages
    render json: all_msgs
  end

  def get_lists
    user = User.find_by(id: params[:id])

    if user
      render json: user.lists
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :profile_picture, :location, :age, :nationality, :languages, :introduction, :hobbies, :goals)
  end
end
