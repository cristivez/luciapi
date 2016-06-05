class OnlineEvent < ActiveRecord::Base

  has_many :online_event_guest , dependent: :destroy


end
