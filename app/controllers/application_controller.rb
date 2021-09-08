class ApplicationController < ActionController::API
  def render_not_found
    render json: {}, status: :not_found # 404
  end
end
