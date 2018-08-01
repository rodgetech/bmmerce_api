class Api::V1::Auth::RegistrationController < ApplicationController
    def register
        if User.find_by_email(register_params[:email])
            render json: { error: 'Email taken. Try to sign in instead.' }, status: :unprocessable_entity
        else
            user = User.new(register_params)
            if user.valid?
                user.save
                # Immediately sign in the user after registration succeeded
                command = AuthenticateUser.call(params[:email], params[:password])
                render json: { auth_token: command.result }
            else
                render json: { error: 'Registration failed', data: user.errors }, status: :unprocessable_entity
            end
        end
    end

    private

    def register_params
        params.permit(:name, :email, :password)
    end
end
