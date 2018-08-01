class Api::V1::ListingType::RentalsController < ApplicationController
    before_action :set_listings, only: :index

    def index
        render json: @listings, 
            meta: { total_pages: @total_pages },
            fields: [:id, :title, :price, :address, :user_id, :is_rental, :created_at], 
            adapter: :json
    end

    private

    def set_listings
        if params[:page] && params[:limit]
            @listings = Listing.where(is_rental: true).order(created_at: :desc).page(params[:page]).per(params[:limit])
            @total_pages = Listing.where(is_rental: true).page(1).per(params[:limit]).total_pages
        elsif params[:limit]
            @listings = Listing.where(is_rental: true).order(created_at: :desc).limit(params[:limit])
        else 
            @listings = Listing.where(is_rental: true).order(created_at: :desc)
        end
    end
end
