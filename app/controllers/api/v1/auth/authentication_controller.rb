class Api::V1::Auth::AuthenticationController < ApplicationController
    def authenticate
        command = AuthenticateUser.call(params[:email], params[:password])
        if command.success?
            render json: { 
                auth_token: command.result,
                has_address: user.address.present?
            }
        else
            render json: { error: command.errors }, status: :unauthorized
        end
    end

    def facebook_authenticate
        user = User.facebook_authenticate(params)
        if user
            user.update_attribute(:provider_image, params[:avatar])
            render json: { 
                auth_token: JsonWebToken.encode(account_id: user.id),
                has_address: user.address.present?
            }
        else
            render json: {}, status: :unauthorized
        end
    end

    def google_authenticate
        user = User.google_authenticate(params)
        if user
            render json: { auth_token: JsonWebToken.encode(account_id: user.id) }
        else
            render json: {}, status: :unauthorized
        end
    end

    def authenticate_business_user
        command = AuthenticateBusinessUser.call(params[:username], params[:password])
        if command.success?
            render json: { auth_token: command.result }
        else
            render json: { error: command.errors }, status: :unauthorized
        end
    end
end
