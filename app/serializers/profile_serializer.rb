class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :password_digest
end
