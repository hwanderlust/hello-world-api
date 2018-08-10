class ChatsController < ApplicationController

  def index
    chats = Chat.all
    render json: chats
  end

  def create
    message = Message.all.find{|m| m.sender_id == chat_params[:sender_id] && m.recipient_id == chat_params[:recipient_id] || m.sender_id == chat_params[:recipient_id] && m.recipient_id == chat_params[:sender_id]}

    if message
      chat = Chat.find_by(id: message.chat_id)
    else
      chat = Chat.create()
    end

    if chat.valid?
      ActionCable.server.broadcast "chats_channel", chat
      # head :ok
      render json: chat
    end
  end

  def show
    chat = Chat.find_by(id: params[:id])
    if chat
      render json: chat
    else
      render json: {error: "Chat not found"}
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:sender_id, :recipient_id)
  end

end
