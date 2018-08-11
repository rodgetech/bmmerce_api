class Api::V1::Admin::EngagementsController < ApiController
    before_action :set_engagement, only: :show

    def index
        render json: @current_account.engagements.order(created_at: :desc), adapter: :json
    end

    def show
        render json: @engagement, adapter: :json
    end

    private

    def set_engagement
        @engagement = Engagement.find(params[:id])
    end
end
