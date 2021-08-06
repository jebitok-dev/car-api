class UsersController < ApplicationController
  skip_before_action :authorize_request, only :create

  def create
    user = User.create!(user_params)
    id = user.id
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = {message: Message.account_creates, auth_token: auth_token, id: id}
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
