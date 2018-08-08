class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :password, :created_at
end
