class Api::V1::UsersController < ApplicationController
    before_action :set_users
    before_action :set_user, only: :show

    def index
        render json: @users, 
            meta: { total_pages: @total_pages },
            adapter: :json
    end

    def show
        render json: @user, adapter: :json
    end

    private
    
    def set_users
        @users = User.order(created_at: :desc).page(params[:page]).per(params[:per])
        @total_pages = User.page(1).per(params[:per]).total_pages
    end

    def set_user
        @user = User.find(params[:id])
    end
end
