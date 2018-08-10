module Api
    module V1
        module Admin
            class MessagesController < ApiController
                
                before_action :set_engagement, only: :index

                def index
                    puts "MY ENGAGEMENT"
                    puts @engagement.to_json
                    render json: @engagement.messages.order(created_at: :desc), adapter: :json
                end

                def create
                    # Create or query engagement
                    if Engagement.between(@current_account.id, params[:recipient_id]).present?
                        @engagement = Engagement.between(@current_account.id, params[:recipient_id]).first
                    else
                        @engagement = Engagement.create!(
                            listing_id: params[:listing_id], 
                            sender_id: @current_account.id, 
                            recipient_id: params[:recipient_id])
                    end
                    # Associate new message to engagement
                    message = @engagement.messages.new(
                        body: params[:body], 
                        engagement_id: @engagement.id, 
                        account_id: @current_account.id)
                    if message.save!
                        # Create message copy and assign to inversed engagement
                        inversed_engagement = Engagement.between(@current_account.id, params[:recipient_id]).where.not(id: @engagement.id).first
                        inversed_message = Message.create(
                            body: params[:body], 
                            account_id: @current_account.id,
                            engagement_id: inversed_engagement.id
                        )
                        $redis.publish 'new-message', MessageSerializer.new(inversed_engagement).to_json
                        render json: message, adapter: :json
                    end
                end

                private

                def set_engagement
                    @engagement = Engagement.find(params[:engagement_id])
                end

            end
        end
    end
end