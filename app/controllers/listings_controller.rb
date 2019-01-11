class ListingsController < ApplicationController
    
    def new         
        @listing = Listing.new
    end

    def create
        p "############################################CREATE"
        list = Listing.new(listing_params)
        list.user_id = user_id
        list.save
        new_id = User.find(user_id).listings[-1].id
        redirect_to listing_path(new_id)
    end

    def index
        @listings = Listing.all 

        min_price = Listing.all.minimum("price") 
        max_price = Listing.all.maximum("price")
        if  !true
            x = min_price
            y = max_price
            @listings.where(price: (min_price..max_price))
        end

        if params[:title]
            @listings = Listing.where('lower(title) LIKE ?', "%#{params[:title].downcase}%") #more secure? % is wildcard in sql?
        end
    end

    def show
        @listing = Listing.find(params[:id])
    end

    def edit
        @listing = Listing.find(params[:id])
    end

    def update
        list = Listing.find(params[:id])
        list.update(listing_params)
        redirect_to listing_path(list.id)
    end

    def destroy
        @listing = Listing.find(params[:id]).delete
        redirect_to root_path
    end

    private
    def listing_params
        params.require(:listing).permit(
            :title, 
            :description, 
            :address, 
            :district, 
            :state, 
            :country, 
            :room, 
            :bath, 
            :adult, 
            :children, 
            :price, 
        )
      end 
end
