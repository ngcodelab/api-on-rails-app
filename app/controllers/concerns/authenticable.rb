module Authenticable
  
  # Devise methods overrides
  def current_user
    @current_user || User.find_by(auth_token: request.headers['Authorization'])
  end
  
  def authenticate_with_token!
    unless current_user.present?
      render json: { errors: "Not autheniticated" }, status: :unauthorized
    end
  end
  
end