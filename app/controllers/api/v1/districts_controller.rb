class Api::V1::DistrictsController < ApplicationController
    skip_before_action :authenticate_request, only: :index

    def index
        districts = District.order(created_at: :desc)
        render json: districts, adapter: :json
    end
end
