class ChatsController < ApplicationController

  def index
    chats = Chat.all
    render json: chats
  end

  def create
    chat = Chat.new()
    if chat.valid?
      chat.save
      ActionCable.server.broadcast "chats_channel", chat
      # head :ok
      render json: chat
    end
  end

end
