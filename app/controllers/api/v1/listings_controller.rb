class Api::V1::ListingsController < ApplicationController
    skip_before_action :authenticate_request
    before_action :set_listings, only: :index
    before_action :set_featured_listings, only: :featured

    def index
        render json: @listings, adapter: :json
    end

    def featured
        render json: @featured_listings, adapter: :json
    end

    def show
        listing = Listing.find(params[:id])
        render json: listing, adapter: :json
    end

    def create
        listing = Listing.new(listing_params)
        if listing.save
            # store_images(listing)
            render json: listing, adapter: :json, status: 201
        else
            render json: { errors: listing.errors }, status: 422
        end
    end

    private

    def set_listings
        if params[:limit]
            @listings = Listing.order(created_at: :desc).limit(params[:limit])
        else 
            @listings = Listing.order(created_at: :desc)
        end
    end

    def set_featured_listings
        if params[:limit]
            @featured_listings = Listing.where(featured: true).order(created_at: :desc).limit(params[:limit])
        else 
            @featured_listings = Listing.where(featured: true).order(created_at: :desc)
        end
    end

    def listing_params
        params.require(:listing).permit(:title, :description, :price, :price_details, :address, :user_id, :images)
    end

    def store_images(listing)
        images = params[:listing][:images]
        images.each {|image| listing.images.create(listing_image: image)} if images
      end
end
