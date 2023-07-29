class ProfilesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :no_records
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        profile = Profile.all
        render json: profile
    end

    def show
        profile = current_user
        if profile
            render json: profile, status: :ok
        else
            render json: {error: "Not Logged In"}, status: :unauthorized
        end
    end


    private

    def finder
        Profile.find(params[:id])
    end

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