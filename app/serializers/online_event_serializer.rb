class OnlineEventSerializer < ActiveModel::Serializer
  attributes :id, :title , :latitude, :longitude, :date, :description
end
