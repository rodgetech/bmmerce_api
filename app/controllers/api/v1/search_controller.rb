class Api::V1::SearchController < ApplicationController
    skip_before_action :authenticate_request
    
    def search
        listings = Listing.search(params[:query])
        render json: listings, adapter: :json
    end
end
