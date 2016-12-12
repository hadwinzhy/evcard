class ApplicationController < ActionController::API
  require 'auth_token'

  protected

  def verify_jwt_token
    head :unauthorized if request.headers['Authorization'].nil? ||
                          !AuthToken.valid?(request.headers['Authorization'].split(' ').last)
  end

end
