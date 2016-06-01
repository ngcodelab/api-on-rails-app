class Api::UsersController < ApplicationController
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
  
  
  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  
end
