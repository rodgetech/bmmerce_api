class ApiController < ApplicationController
    before_action :authenticate_request

    private

    def authenticate_request
        @current_account = AuthorizeApiRequest.call(request.headers).result
        @current_business = nil
        if @current_account
            @current_business = @current_account.business if @current_account.type == 'BusinessUser' 
        end
        render json: { error: 'Not Authorized' }, status: 401 unless @current_account
    end
end
