class Api::V1::ListingType::BusinessesController < ApplicationController
    before_action :set_business, only: :show
    before_action :set_listings, only: :show

    def show
        render json: @listings, 
            fields: [:title, :price, :description], 
            adapter: :json
    end

    private

    def set_business
        @business = Business.find(params[:id])
    end

    def set_listings
        @listings = @business.listings.order(created_at: :desc)
    end
end
