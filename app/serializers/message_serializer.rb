class MessageSerializer < ActiveModel::Serializer
  # attributes to be serialized  
  attributes :id, :content, :created_by, :created_at
end
