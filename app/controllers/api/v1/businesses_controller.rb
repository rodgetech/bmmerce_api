class Api::V1::BusinessesController < ApplicationController
    before_action :set_businesses, only: :index
    before_action :set_business, only: :show

    def index
        render json: @businesses, adapter: :json
    end

    def show
        render json: @business, adapter: :json
    end

    private

    def set_businesses
        @businesses = Business.order(created_at: :desc)
    end

    def set_business
        @business = Business.find(params[:id])
    end
end
