class Api::SessionsController < ApplicationController
  
  def create
    user_email = params[:session][:email]
    user_password = params[:session][:password]
    
    user = user_email.present? && user.find_by(email: user_email)
    
    # valid_password is the method provided by devise
    if user.valid_password?(user_password)
       # The store: false option prevents the user’s identity from being
       # saved in the session, so subsequent API requests will still
       # require the secret and secret_id.
      sign_in(user, store: false)
      user.generate_unique_auth_token!
      user.save!
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: "Invalid email or password." }, status: 422
    end
    
  end
  
end
