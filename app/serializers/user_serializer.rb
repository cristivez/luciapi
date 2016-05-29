class UserSerializer < ActiveModel::Serializer
  attributes :id, :email , :firstName, :lastName, :phoneNumber, :birthDate
end
