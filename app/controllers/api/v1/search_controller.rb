class Api::V1::SearchController < ApplicationController
    before_action :set_listings, only: :search
    
    def search
        if @listings.empty?
            head :ok
        else
            render json: @listings, 
                meta: { total_pages: @total_pages },
                adapter: :json
        end
    end

    private

    def set_listings
        if params[:page]
            @listings = Listing.search(params[:query]).page(params[:page])
            @total_pages = Listing.search(params[:query]).page(1).total_pages
        else 
            @listings = Listing.search(params[:query]).order(created_at: :desc)
        end
    end
end
