class Auth::SessionsController < Devise::SessionsController
  # Our method for encoding/decoding JWT
  require 'auth_token'

  #POST /sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?

    # Return our jwt token
    token = AuthToken.issue_token({user_id: resource.id})
    # in rails 5 api, just render data
    render json: {user: resource.email, token: token}

    # Not use devise default response
    # respond_with resource, location: after_sign_in_path_for(resource)
  end
end
