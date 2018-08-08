class MessageSerializer < ActiveModel::Serializer
  attributes :id, :text, :sender_id, :recipient_id, :created_at
end
