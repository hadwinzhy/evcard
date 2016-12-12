class V2::UsersController < V2::BaseController
  def index
    users = []
    render json: users
  end
end
