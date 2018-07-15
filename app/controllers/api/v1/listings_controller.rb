class Api::V1::ListingsController < ApplicationController
    def index
        listings = Listing.order(created_at: :desc)
        render json: listings, adapter: :json
    end

    def create
        listing = Listing.new(listing_params)
        if listing.save
            render json: listing, adapter: :json, status: 201
        else
            render json: { errors: listing.errors }, status: 422
        end
    end

    private

    def listing_params
        params.permit(:title, :description, :price, :price_details, :address, :user_id)
    end
end
