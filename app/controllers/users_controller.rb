class UsersController < ApplicationController

  def index
    users = User.all
    render json: users
  end

  def create
    user = User.new(user_params)

    if user.valid?
      user.save
      ActionCable.server.broadcast "users_channel", user
      render json: user
    else
      render json: {error: "user not created"}, status: 401
    end
  end

  def login
    user = User.find_by(username: user_params[:username])

    if user && user.authenticate(user_params[:password])
      render json: user
    else
      render json: {error: "login failed"}, status: 401
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

  def picture
    byebug
    # params[:imgUrl]
    render json: something
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :profile_picture)
  end
end
