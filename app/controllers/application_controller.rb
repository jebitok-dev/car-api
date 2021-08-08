class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  before_action :authorize_user
  attr_reader :current_user

  private

  def authorize_user
    @current_user = (AuthorizeapiRequest.new(request.headers).call)[:user]
  end
end
