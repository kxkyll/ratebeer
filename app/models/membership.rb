class Membership < ActiveRecord::Base
    validates :user_id, uniqueness: {scope: :beer_club_id, message:  "can not join one club several times"}
    belongs_to :beer_club
    belongs_to :user
end
