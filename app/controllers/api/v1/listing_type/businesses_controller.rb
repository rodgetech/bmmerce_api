class Api::V1::ListingType::BusinessesController < ApplicationController
    before_action :set_business, only: :show
    before_action :set_listings, only: :show

    def show
        render json: @listings,
            meta: { total_pages: @total_pages }, 
            fields: [:title, :price, :description, :created_at], 
            adapter: :json
    end

    private

    def set_business
        @business = Business.find(params[:id])
    end

    def set_listings
        @listings = @business.listings.order(created_at: :desc).page(params[:page])
        @total_pages = @business.listings.page(1).total_pages
    end
end
