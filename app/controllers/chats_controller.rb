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
      default_msg = Message.create(text: "Welcome to your new chat!", chat_id: chat.id, sender_id: chat_params[:sender_id], recipient_id: chat_params[:recipient_id])
    end

    if chat.valid?
      ActionCable.server.broadcast "chats_channel", chat
      # head :ok
      # maybe create chat object with respective messages inside
      # msgs = chat.messages
      # chatObj = chat.clone
      # byebug
      # chatObj[:messages] = msgs
      # puts chatObj
      # render json: chatObj

      render json: chat
    end
  end

  def show
    chat = Chat.find_by(id: params[:id])
    messages = chat.messages

    render json: messages
  end

  private

  def chat_params
    params.require(:chat).permit(:sender_id, :recipient_id)
  end

end
