class Api::V1::ListingType::ListingsController < ApplicationController
    before_action :set_listings, only: :index

    def index
        render json: @listings, 
            meta: { total_pages: @total_pages },
            fields: [:id, :title, :price, :address, :description, :account_id, :is_rental, :created_at], 
            adapter: :json
    end

    def show
        listing = Listing.find(params[:id])
        render json: listing, adapter: :json
    end


    private

    def set_listings
        if params[:page] && params[:limit]
            @listings = Listing.order(created_at: :desc).page(params[:page]).per(params[:limit])
            @total_pages = Listing.page(1).per(params[:limit]).total_pages
        elsif params[:limit]
            @listings = Listing.order(created_at: :desc).limit(params[:limit])
        else 
            @listings = Listing.order(created_at: :desc)
        end
    end
end
