module Api
    module V1
        module Admin
            class EngagementsController < ApiController
                before_action :set_engagement, only: [:show, :mark_messages_read]

                # Get the current signed in user's engagements
                def index
                    render json: @current_account.engagements.order(created_at: :desc), 
                        current_account_id: @current_account.id, adapter: :json
                end

                def show
                    render json: @engagement, adapter: :json
                end

                def mark_messages_read
                    @engagement.messages.where(recipient_id: @current_account.id, read: false).update_all(read: true)
                    # Return updated unread messages count
                    unread_count = Message.where(recipient_id: @current_account.id, read: false).count
                    render json: unread_count, adapter: :json
                end

                private

                def set_engagement
                    @engagement = Engagement.find(params[:id])
                end
            end
        end
    end
end