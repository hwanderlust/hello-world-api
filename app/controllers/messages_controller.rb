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

  def detection
    detection_url = "https://translation.googleapis.com/language/translate/v2/detect?key=#{api_key}&q=#{detection_params[:msg]}"
    detection_response = JSON.parse(RestClient.post detection_url, {content_type: :json, accept: :json})
    byebug
    orig_lang = detection_response["data"]["detections"][0][0]["language"]
    puts orig_lang

    render json: detection_response
  end

  def translate
    resp_format = "text"
    translate_base_url = "https://translation.googleapis.com/language/translate/v2"

    translate_url = "#{translate_base_url}?key=#{api_key}&q=#{translate_params[:msg]}&source=#{translate_params[:fromLang]}&target=#{translate_params[:toLang]}&format=#{resp_format}"
    puts translate_url

    response = RestClient.post translate_url, {content_type: :json, accept: :json}
    translation_response = JSON.parse(response)
    puts translation_response

    render json: translation_response
  end

  def add_to_list
    list = List.find_by(id: with_list_params[:list_id])

    if list
      message = Message.find_by(id: with_list_params[:msg_id])

      list.messages << message
      render json: list.messages
    end
  end

  def remove_from_list
    list = List.find_by(id: with_list_params[:list_id])

    if list
      message = Message.find_by(id: with_list_params[:msg_id])
      message[:list_id] = nil
      message.save
      render json: list.messages
    end
  end

  private

  def message_params
    params.require(:message).permit(:text, :chat_id, :sender_id, :recipient_id)
  end

  def translate_params
    params.require(:message).permit(:msg, :fromLang, :toLang)
  end

  def detection_params
    params.require(:detection).permit(:msg)
  end

  def with_list_params
    params.require(:message).permit(:msg_id, :list_id)
  end

  def api_key
    Rails.application.credentials[:google_api_key]
  end

end
