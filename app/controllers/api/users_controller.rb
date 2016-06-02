class Api::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:update, :destroy]
  respond_to :json
  
  def show
    respond_with User.find(params[:id])
  end
  
  def create
    user = User.new(user_params)
    if user.save
      # Status 202 says that the request has been fulfilled 
      # and resulted in a new resource being created. 
      render json: user, status: 201, location: [:api, user]
    else
      # Status 422 represents unprocessable entity
      render json: {errors: user.errors}, status: 422
    end
  end
  
  
  def update
    user = current_user
    if user.update(user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: {errors: user.errors}, status: 422
    end
  end
  
  def destroy
    current_user.destroy
    # HTTP status 204 signifies 'No Content' which means
    # The server successfully processed the request and is
    # not returning any content.
    # The following statement just send back header in the 
    # response with status 204.
    head 204
  end
  
  
  
  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  
end
