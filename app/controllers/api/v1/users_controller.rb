class Api::V1::UsersController < ApplicationController
    before_action :set_users

    def index
        render json: @users, 
            meta: { total_pages: @total_pages },
            adapter: :json
    end

    private
    
    def set_users
        @users = User.order(created_at: :desc).page(params[:page]).per(params[:per])
        @total_pages = User.page(1).per(params[:per]).total_pages
    end
end
