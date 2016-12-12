class V1::BaseController < ApplicationController

  before_filter :verify_jwt_token

end
