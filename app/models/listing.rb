class Listing < ApplicationRecord
    belongs_to :user

    def filter(search)
        p search
    end
end
