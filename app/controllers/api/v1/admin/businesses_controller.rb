class Api::V1::Admin::BusinessesController < ApiController
    def show
        render json: @current_business, adapter: :json
    end

    def update
        if @current_business.update_attributes(business_params)
            # store_images(listing)
            @current_business.reload
            render json: @current_business, adapter: :json, status: 200
        else
            render json: { errors: @current_business.errors }, status: 422
        end
    end

    private 
    
    def business_params
        params.permit(:name, :address)
    end
end
