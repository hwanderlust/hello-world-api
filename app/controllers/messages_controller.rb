require 'rest_client'

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

  def translate
    puts translate_params
    detection_url = "https://translation.googleapis.com/language/translate/v2/detect?key=#{api_key}&q=#{translate_params}"
    detection_response = JSON.parse(RestClient.post detection_url, {content_type: :json, accept: :json})
    orig_lang = detection_response["data"]["detections"][0][0]["language"]
    puts orig_lang

    translate_to_lang = translate_params[:lang]
    resp_format = "text"
    translate_base_url = "https://translation.googleapis.com/language/translate/v2"
    translate_url = "#{translate_base_url}?key=#{api_key}&q=#{translate_params[:msg]}&source=#{orig_lang}&target=#{translate_to_lang}&format=#{resp_format}"
    puts translate_url

    response = RestClient.post translate_url, {content_type: :json, accept: :json}
    translation_response = JSON.parse(response)
    puts translation_response

    render json: translation_response
  end

  private

  def message_params
    params.require(:message).permit(:text, :chat_id, :sender_id, :recipient_id)
  end

  def translate_params
    params.require(:message).permit(:msg, :lang)
  end

  def api_key
    key = ""
  end

end
