class ChatsChannel < ApplicationCable::Channel
  def subscribed
    puts "~~~~~~~~~~~~~~ChatsChannel: #{params}"
    stream_from "chats_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
