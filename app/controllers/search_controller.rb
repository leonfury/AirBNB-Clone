class SearchController < ApplicationController

    #after searching via active record
    #display search results in app/views/search/results
    def results
        
        @listings = Listing.where('title LIKE ?', "%#{params[:title]}%") #more secure? % is wildcard in sql?
        
    end

end
