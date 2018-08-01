class Api::V1::Admin::ListingsController < ApiController

    # Render either business or account listings
    def index
        if @current_business
            render json: @current_business.listings, adapter: :json
        else
            render json: @current_account.listings, adapter: :json
        end
    end

    def show
        listing = Listing.find(params[:id])
        render json: listing, adapter: :json
    end

    # Create a listing associated to either a business
    # and business account or just to a regular account
    def create
        listing = @current_account.listings.new(listing_params)
        if listing.valid?
            listing.save
            store_images(listing)
            listing.images.reload
            render json: listing, 
                include: 'images.first',
                fields: [:id, :title, :price, :address, :account_id, :is_rental, :created_at],
                adapter: :json, status: 201
        else
            render json: { errors: listing.errors }, status: 422
        end
    end

    def update
        listing = Listing.find(params[:id])
        if listing.update(listing_params)
            store_images(listing)
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
        params.permit(:id, :title, :description, :is_rental, :price, :address)
    end

    def store_images(listing)
        images = params[:images]
        images.each {|image| listing.images.create(listing_image: image)} if images
    end

end
