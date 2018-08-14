class User < ApplicationRecord
  has_secure_password

  validates  :username, {presence: true, length: {minimum: 4, maximum: 70}}
  validates  :age, {presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 16, less_than_or_equal_to: 122 }}
  validates  :password, {length: {minimum: 6}, allow_nil: true}
  validates :profile_picture, {presence: true}
  validates :location, {presence: true}
  validates :nationality, {presence: true}
  validates :languages, {presence: true}
  validates :introduction, {presence: true}
  validates :hobbies, {presence: true}
  validates :goals, {presence: true}

  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'sender_id'
  has_many :received_messages, :class_name => 'Message', :foreign_key => 'recipient_id'
  has_many :chats, through: :messages
end
