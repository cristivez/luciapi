class OnlineEvent < ActiveModel::Serializer
  attributes :id, :title , :latitude, :longitude, :date, :description
end
