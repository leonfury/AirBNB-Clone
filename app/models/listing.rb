class Listing < ApplicationRecord
    belongs_to :user
    paginates_per 15
    mount_uploaders :images, ImageUploader
end
