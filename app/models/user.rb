class User < ApplicationRecord
  has_secure_password
  # has_many :messages
  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'sender_id'
  has_many :received_messages, :class_name => 'Message', :foreign_key => 'recipient_id'
  has_many :chats, through: :messages
end
