class AuthenticationController < ApplicationController
  skip_before_action :authorize_user, only: :authenticate

  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token, id: User.find_by(email: auth_params[:email]).id)
  end

  private

  def auth_params
    params.permit(:email, :password, :id)
  end
end
