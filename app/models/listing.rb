class Listing < ApplicationRecord
    belongs_to :user
    has_many :bookings
    paginates_per 15
    mount_uploaders :images, ImageUploader
end
