module Api
    module V1
        module Admin
            class MessagesController < ApiController
                before_action :set_messages, only: :index

                def index
                    if @engagement
                        render json: @messages, meta: { total_pages: @total_pages }, adapter: :json
                    else
                        head :no_content
                    end
                end

                def unread
                    unread_count = Message.where(recipient_id: @current_account.id, read: false).count
                    puts "UNREADDDD"
                    puts unread_count
                    render json: unread_count, adapter: :json
                end

                # @TODO Refactor
                def create
                    # Create or query engagement
                    if Engagement.between(@current_account.id, params[:recipient_id], params[:listing_id]).present?
                        # @engagement = Engagement.between(@current_account.id, params[:recipient_id], params[:listing_id]).first
                        @engagement = Engagement.where(sender_id: @current_account.id, recipient_id: params[:recipient_id], listing_id: params[:listing_id]).first
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
                        account_id: @current_account.id,
                        recipient_id: params[:recipient_id],
                        read: true
                    )
                    if message.save!
                        # Create message copy and assign to inversed engagement
                        inversed_engagement = Engagement.between(@current_account.id, params[:recipient_id], params[:listing_id]).where.not(id: @engagement.id).first
                        inversed_message = Message.create(
                            body: params[:body], 
                            engagement_id: inversed_engagement.id,
                            account_id: @current_account.id,
                            recipient_id: params[:recipient_id]
                        )
                        $redis.publish 'new-message', MessageSerializer.new(inversed_message).to_json
                       
                        # Dispatch new message notification
                        notification_params = {"app_id" => "6e1f4645-71e3-469e-838a-16d2a3fdd1b1", 
                            "contents" => {"en" => message.body},
                            "headings" => {"en" => "New Message From #{message.account.name}"},
                            "include_player_ids" => [message.recipient.player_id],
                            "data" => {"message" => message}
                           }

                        uri = URI.parse('https://onesignal.com/api/v1/notifications')
                        http = Net::HTTP.new(uri.host, uri.port)
                        http.use_ssl = true
                        
                        request = Net::HTTP::Post.new(uri.path,
                                                        'Content-Type'  => 'application/json;charset=utf-8',
                                                        'Authorization' => "Basic YmVhMjg0NDYtMjZkMi00YjQyLWFlZGUtYmE4ZmIyYjg5ZTMy")
                        request.body = notification_params.as_json.to_json
                        response = http.request(request) 
                        puts "PUSHER RESPONSE"
                        puts response
                        render json: message, adapter: :json
                    end
                end

                private

                def set_messages
                    @engagement = Engagement.between(@current_account.id, params[:recipient_id], params[:listing_id]).first
                    # puts "THE ENGAGEMENTS"
                    # puts @engagement.id
                    if @engagement
                        @messages = @engagement.messages.order(created_at: :desc).page(params[:page]).per(14)
                        @total_pages = @messages.page(1).per(14).total_pages
                    end
                end
            end
        end
    end
end