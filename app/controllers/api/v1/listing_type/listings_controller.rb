class Api::V1::ListingType::ListingsController < ApplicationController
    before_action :set_listings, only: :index

    def index
        render json: @listings, 
            meta: { total_pages: @total_pages },
            adapter: :json
    end

    def show
        listing = Listing.find(params[:id])
        render json: listing, adapter: :json
    end


    private

    def set_listings
        if params[:swlat]
            bounds = [params[:swlat], params[:swlong], params[:nelat], params[:nelong]]
            @listings = Listing.order(created_at: :desc).within_bounding_box(bounds).page(params[:page]).per(20)
            @total_pages = Listing.within_bounding_box(bounds).page(1).per(20).total_pages
        elsif params[:latitude] && params[:longitude]
            @listings = Listing.order(created_at: :desc).near([params[:latitude], params[:longitude]]).page(params[:page]).per(20)
            @total_pages = Listing.near([params[:latitude], params[:longitude]]).page(1).per(20).total_pages
        else 
            @listings = Listing.order(created_at: :desc).page(params[:page]).per(20)
            @total_pages = Listing.page(1).per(20).total_pages
        end
    end
end
