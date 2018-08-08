class MessagesChannel < ApplicationCable::Channel
  def subscribed
    puts "~~~~~~~~~~~~~~~~~~~~MessagesChannel: #{params}"
    chat = Chat.find(params[:chat])
    stream_for chat
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
