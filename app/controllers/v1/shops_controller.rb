class V1::ShopsController < V1::BaseController
  def index
    users = Shop.page(params[:page] || 1)
    render json: users, meta: pagination_meta(users)
  end

  def all_cars_in_shop(shopSeq)
  end

  private
  def pagination_meta(object)
    {
      current_page: object.current_page,
      next_page: object.next_page,
      prev_page: object.previous_page,
      total_pages: object.total_pages,
      total_count: object.total_entries
    }
  end
end
