class Api::V1::Admin::AccountsController < ApiController
    def show
        render json: @current_account, adapter: :json
    end

    def update
        if @current_account.update_attributes(account_params)
            # store_images(listing)
            @current_account.reload
            render json: @current_account, adapter: :json, status: 200
        else
            render json: { errors: @current_account.errors }, status: 422
        end
    end

    def address
        if @current_account.update_attributes!(
                address: params[:address],
                latitude: params[:latitude],
                longitude: params[:longitude]
            )
            render json: @current_account, adapter: :json, status: 200
        else
            render json: { errors: @current_account.errors }, status: 422
        end
    end

    private 
    
    def account_params
        params.permit(:name, :email, :password, :avatar)
    end
end
