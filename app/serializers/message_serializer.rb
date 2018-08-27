class MessageSerializer < ActiveModel::Serializer
  attributes :id, :text, :sender_id, :recipient_id, :created_at, :list_id
end
