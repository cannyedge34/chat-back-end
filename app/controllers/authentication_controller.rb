# app/controllers/authentication_controller.rb
class AuthenticationController < ApplicationController
  # return auth token once user is authenticated
  skip_before_action :authorize_request, only: :authenticate
  
  def authenticate
    auth_token =
      AuthenticateUser.new(auth_params[:username], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  private

  def auth_params
    params.permit(:username, :password)
  end
end