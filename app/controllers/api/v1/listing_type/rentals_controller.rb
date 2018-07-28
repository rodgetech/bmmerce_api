class Api::V1::ListingType::RentalsController < ApplicationController
    skip_before_action :authenticate_request
    before_action :set_listings, only: :index

    def index
        render json: @listings, 
            fields: [:id, :title, :price, :address, :user_id, :is_rental, :created_at, :images], 
            adapter: :json
    end

    private

    def set_listings
        if params[:limit]
            @listings = Listing.where(is_rental: true).order(created_at: :desc).limit(params[:limit])
        else 
            @listings = Listing.where(is_rental: true).order(created_at: :desc)
        end
    end
end
