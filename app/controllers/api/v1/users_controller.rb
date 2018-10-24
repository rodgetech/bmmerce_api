class Api::V1::UsersController < ApplicationController
    before_action :set_users
    before_action :set_user, only: :show
    before_action :set_listings, only: :listings

    def index
        render json: @users, 
            meta: { total_pages: @total_pages },
            adapter: :json
    end

    def show
        render json: @user, adapter: :json
    end

    def listings
        render json: @listings, 
            meta: { total_pages: @total_pages },
            adapter: :json
    end

    private
    
    def set_users
        @users = User.order(created_at: :desc).page(params[:page]).per(params[:per])
        @total_pages = User.page(1).per(params[:per]).total_pages
    end

    def set_user
        @user = User.find(params[:id])
    end

    def set_listings
        user = User.find(params[:id])
        @listings = user.listings.order(created_at: :desc).page(params[:page]).per(15)
        @total_pages = user.listings.page(1).per(15).total_pages
    end
end
