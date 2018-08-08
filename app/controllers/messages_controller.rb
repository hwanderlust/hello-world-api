class MessagesController < ApplicationController

  def create
    message = Message.new(message_params)
    chat = Chat.find(message_params[:chat_id])
    puts "~~~~~~~~~~~~~msg: #{message}, chat: #{chat}"
    
    if message.valid?
      message.save
      MessagesChannel.broadcast_to chat, message
      head :ok
    end
  end

  private

  def message_params
    params.require(:message).permit(:text, :chat_id, :sender_id, :recipient_id)
  end
end
