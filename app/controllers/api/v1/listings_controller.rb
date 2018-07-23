class Api::V1::ListingsController < ApplicationController
    skip_before_action :authenticate_request, except: [:update, :user_listings, :destroy]
    before_action :set_listings, only: :index
    before_action :set_featured_listings, only: :featured
    before_action :set_user_listings, only: :user_listings

    def index
        render json: @listings, adapter: :json
    end

    def featured
        render json: @featured_listings, adapter: :json
    end

    def user_listings
        render json: @user_listings, adapter: :json
    end

    def show
        listing = Listing.find(params[:id])
        render json: listing, adapter: :json
    end

    def create
        listing = Listing.new(listing_params)
        if listing.valid?
            listing.save
            store_images(listing)
            render json: listing, adapter: :json, status: 201
        else
            render json: { errors: listing.errors }, status: 422
        end
    end

    def update
        listing = Listing.find(params[:id])
        if listing.update(listing_params)
            store_images(listing)
            listing = Listing.find(listing.id)
            render json: listing, adapter: :json, status: 200
        else
            render json: { errors: listing.errors }, status: 422
        end
    end

    def destroy
        Listing.find(params[:id]).destroy
        head 204
    end

    private

    def listing_params
        params.permit(:id, :title, :description, 
            :price, :address, :contact_name, 
            :contact_email, :contact_number, :email_flag, 
            :phone_call_flag, :sms_flag, :whatsapp_flag, :user_id)
    end

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

    def set_user_listings
        if params[:limit]
            @user_listings = Listing.where(user_id: params[:user_id]).order(created_at: :desc).limit(params[:limit])
        else 
            @user_listings = Listing.where(user_id: params[:user_id]).order(created_at: :desc)
        end
    end

    def store_images(listing)
        images = params[:images]
        images.each {|image| listing.images.create(listing_image: image)} if images
    end
end
