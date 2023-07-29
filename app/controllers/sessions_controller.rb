class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token
    rescue_from ActiveRecord::RecordNotFound, with: :no_records
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def login
        user = Profile.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            render json: { message: "Logged in successfully",user:current_user }, status: :ok
        else
            render json: { error: "Invalid email or password" }, status: :unauthorized
        end
    end

    def create
        profile = Profile.create(user_params)
        user = Profile.find_by(email: params[:email])
        if user
            session[:user_id] = user.id
            render json: { message: "Logged in successfully",user:current_user }, status: :ok
        else
            render json: { error: "Invalid email or password" }, status: :unauthorized
        end
    end

    def logout
        session.delete(:user_id)
        render json: { message: "Logged out successfully" }, status: :ok
    end

    private
    def user_params
        params.permit(:username, :email, :password, :password_confirmation)
    end

    def no_records
        render json: {error: "Profile not found"}, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end