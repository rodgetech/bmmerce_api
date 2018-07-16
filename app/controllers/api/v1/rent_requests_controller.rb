class Api::V1::RentRequestsController < ApplicationController
    skip_before_action :authenticate_request

    def create
        rent_request = RentRequest.new(rent_request_params)
        if rent_request.valid?
            rent_request.save
            render json: rent_request, adapter: :json, status: 201
        else
            render json: { errors: rent_request.errors }, status: 422
        end
    end

    private

    def rent_request_params
        params.permit(:name, :contact_number, :rent_date, :comment, :listing_id)
    end
end
